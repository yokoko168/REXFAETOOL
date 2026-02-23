cat > /conf/qga-install/install-guest.sh <<'EOF'
#!/bin/sh
set -eu

BUNDLE_TGZ="${1:-/conf/qga-install/qga-bundle.tar.gz}"
DEST="/opt/qga-bundle"
PROFILE="/conf/etc/profile"

echo "[1/6] Prepare dirs..."
mkdir -p /opt /var/run /dev/virtio-ports

echo "[2/6] Install bundle..."
rm -rf "$DEST"
tar -xzf "$BUNDLE_TGZ" -C /opt

# Normalize layout: /opt/qga-bundle/*
if [ ! -x /opt/qga-bundle/qemu-ga ] && [ -x /opt/qga-bundle/qga-bundle/qemu-ga ]; then
  mv /opt/qga-bundle/qga-bundle/* /opt/qga-bundle/
  rmdir /opt/qga-bundle/qga-bundle 2>/dev/null || true
fi

chmod +x /opt/qga-bundle/qemu-ga /opt/qga-bundle/lib/ld-linux-x86-64.so.2 2>/dev/null || true

echo "[3/6] Ensure autostart snippet (BusyBox-safe)..."
SNIP_BEGIN="# --- QGA AUTOSTART BEGIN ---"
SNIP_END="# --- QGA AUTOSTART END ---"

# Remove old snippet via sed (BusyBox compatible)
if [ -f "$PROFILE" ]; then
  sed -i "/^${SNIP_BEGIN}\$/,/^${SNIP_END}\$/d" "$PROFILE" 2>/dev/null || true
fi

cat >> "$PROFILE" <<'SNIP'
# --- QGA AUTOSTART BEGIN ---
if [ -x /opt/qga-bundle/qemu-ga ] && [ -d /sys/class/virtio-ports ]; then
  mkdir -p /dev/virtio-ports /var/run
  for n in /sys/class/virtio-ports/vport*/name; do
    [ -f "$n" ] || continue
    if [ "$(cat "$n")" = "org.qemu.guest_agent.0" ]; then
      vp="${n%/name}"
      mm="$(cat "$vp/dev")"
      major="${mm%:*}"; minor="${mm#*:}"
      [ -e /dev/virtio-ports/org.qemu.guest_agent.0 ] || mknod /dev/virtio-ports/org.qemu.guest_agent.0 c "$major" "$minor"
      chmod 600 /dev/virtio-ports/org.qemu.guest_agent.0
      if ! ps w | grep -q "[q]emu-ga"; then
        /opt/qga-bundle/lib/ld-linux-x86-64.so.2 --library-path /opt/qga-bundle/lib \
          /opt/qga-bundle/qemu-ga --daemonize --pidfile /var/run/qemu-ga.pid \
          --method virtio-serial --path /dev/virtio-ports/org.qemu.guest_agent.0 >/dev/null 2>&1
      fi
      break
    fi
  done
fi
# --- QGA AUTOSTART END ---
SNIP

sync

echo "[4/6] Start qemu-ga now..."
# Run snippet once without sourcing entire profile
if [ -d /sys/class/virtio-ports ]; then
  for n in /sys/class/virtio-ports/vport*/name; do
    [ -f "$n" ] || continue
    if [ "$(cat "$n")" = "org.qemu.guest_agent.0" ]; then
      vp="${n%/name}"
      mm="$(cat "$vp/dev")"
      major="${mm%:*}"; minor="${mm#*:}"
      [ -e /dev/virtio-ports/org.qemu.guest_agent.0 ] || mknod /dev/virtio-ports/org.qemu.guest_agent.0 c "$major" "$minor"
      chmod 600 /dev/virtio-ports/org.qemu.guest_agent.0
      /opt/qga-bundle/lib/ld-linux-x86-64.so.2 --library-path /opt/qga-bundle/lib \
        /opt/qga-bundle/qemu-ga --daemonize --pidfile /var/run/qemu-ga.pid \
        --method virtio-serial --path /dev/virtio-ports/org.qemu.guest_agent.0 >/dev/null 2>&1
      break
    fi
  done
fi

echo "[5/6] Validate..."
ps w | grep -E "[q]emu-ga" >/dev/null || { echo "ERROR: qemu-ga not running"; exit 2; }

echo "[6/6] Done."
EOF

chmod +x /conf/qga-install/install-guest.sh
