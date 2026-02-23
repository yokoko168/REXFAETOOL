#!/bin/sh
set -eu

BUNDLE_TGZ="${1:-./qga-bundle.tar.gz}"
DEST="/opt/qga-bundle"
PROFILE="/conf/etc/profile"

echo "[1/6] Prepare dirs..."
mkdir -p /opt /var/run

echo "[2/6] Install bundle to ${DEST} ..."
rm -rf "$DEST"
mkdir -p "$DEST"
tar -xzf "$BUNDLE_TGZ" -C /opt
# 如果你的 tar 內層是 qga-bundle/，確保落點正確：
if [ ! -x /opt/qga-bundle/qemu-ga ] && [ -x /opt/qga-bundle/qga-bundle/qemu-ga ]; then
  mv /opt/qga-bundle/qga-bundle/* /opt/qga-bundle/
  rmdir /opt/qga-bundle/qga-bundle || true
fi

chmod +x /opt/qga-bundle/qemu-ga /opt/qga-bundle/lib/ld-linux-x86-64.so.2 || true

echo "[3/6] Write autostart snippet to ${PROFILE} ..."
SNIP_BEGIN="# --- QGA AUTOSTART BEGIN ---"
SNIP_END="# --- QGA AUTOSTART END ---"

# Remove old snippet if exists
if grep -q "$SNIP_BEGIN" "$PROFILE" 2>/dev/null; then
  awk -v b="$SNIP_BEGIN" -v e="$SNIP_END" '
    $0==b {in=1; next}
    $0==e {in=0; next}
    !in {print}
  ' "$PROFILE" > /tmp/profile.new && mv /tmp/profile.new "$PROFILE"
fi

cat >> "$PROFILE" <<'EOF'
# --- QGA AUTOSTART BEGIN ---
# Ensure virtio-ports devnode exists, then start qemu-ga with bundled loader.
if [ -x /opt/qga-bundle/qemu-ga ] && [ -d /sys/class/virtio-ports ]; then
  mkdir -p /dev/virtio-ports /var/run

  # Find the port which name is org.qemu.guest_agent.0
  for n in /sys/class/virtio-ports/vport*/name; do
    [ -f "$n" ] || continue
    if [ "$(cat "$n")" = "org.qemu.guest_agent.0" ]; then
      vp="${n%/name}"
      mm="$(cat "$vp/dev")"
      major="${mm%:*}"; minor="${mm#*:}"

      [ -e /dev/virtio-ports/org.qemu.guest_agent.0 ] || mknod /dev/virtio-ports/org.qemu.guest_agent.0 c "$major" "$minor"
      chmod 600 /dev/virtio-ports/org.qemu.guest_agent.0

      # Start agent if not running
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
EOF

sync

echo "[4/6] Start qemu-ga now (no reboot needed for agent itself)..."
# Run the same logic once now
sh -c '. /conf/etc/profile >/dev/null 2>&1 || true'

echo "[5/6] Validate..."
ps w | grep -E "[q]emu-ga" || { echo "ERROR: qemu-ga not running"; exit 2; }
ls -l /sys/class/virtio-ports/*/name | head || true

echo "[6/6] Done."
echo "Note: If PVE side QGA channel (virtserialport org.qemu.guest_agent.0) is not configured, you still need to set it on the host."
