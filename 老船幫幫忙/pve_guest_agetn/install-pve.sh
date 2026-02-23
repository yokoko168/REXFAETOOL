#!/bin/bash
set -euo pipefail

VMID="${1:?vmid required}"
VMIP="${2:?vm ip required}"
REPO_BASE_URL="${3:-https://raw.githubusercontent.com/<YOU>/<REPO>/main}"  # 改成你的
TMPDIR="/tmp/qga-${VMID}"

mkdir -p "$TMPDIR"
cd "$TMPDIR"

echo "[1/6] Download artifacts..."
curl -fsSL "${REPO_BASE_URL}/qga-bundle.tar.gz" -o qga-bundle.tar.gz
curl -fsSL "${REPO_BASE_URL}/install-guest.sh" -o install-guest.sh
chmod +x install-guest.sh

echo "[2/6] Configure QGA channel (virtserialport) on PVE..."
qm set "$VMID" --args "-chardev socket,path=/var/run/qga-${VMID}.sock,server=on,wait=off,id=qga0 -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0"

echo "[3/6] Upload into guest..."
scp -o StrictHostKeyChecking=no qga-bundle.tar.gz install-guest.sh "root@${VMIP}:/tmp/"

echo "[4/6] Run guest installer..."
ssh -o StrictHostKeyChecking=no "root@${VMIP}" "sh /tmp/install-guest.sh /tmp/qga-bundle.tar.gz"

echo "[5/6] Restart VM (stop/start, not reboot)..."
qm stop "$VMID" || true
sleep 2
qm start "$VMID"

echo "[6/6] Verify ping (may need a few seconds)..."
sleep 3
qm agent "$VMID" ping || true

echo "Done."
