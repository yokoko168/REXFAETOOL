🛠️ V2AC（控制器一鍵安裝）

自動判斷 glibc / musl，自動選擇 /data（可寫）或 /tmp

set -e

# 判斷 runtime
if [ -e /lib/ld-linux-aarch64.so.1 ]; then
  RUNTIME=glibc
elif [ -e /lib/ld-musl-aarch64.so.1 ]; then
  RUNTIME=musl
else
  echo "❌ Unsupported runtime"
  exit 1
fi
echo "✅ Runtime: $RUNTIME"

# 選擇安裝路徑
if [ -d /data ] && touch /data/.rw 2>/dev/null; then
  rm -f /data/.rw
  ROOT=/data
else
  ROOT=/tmp
fi

INSTALL_DIR="$ROOT/netdata_v2_ac"
PKG="netdata-controller-aarch64-${RUNTIME}.tar.gz"
URL="https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/${PKG}"

cd /tmp
curl -k -L -o ac.tar.gz "$URL" || wget --no-check-certificate -O ac.tar.gz "$URL"

rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
tar -xzf ac.tar.gz -C "$INSTALL_DIR"

chmod +x "$INSTALL_DIR/usr/sbin/netdata"
mkdir -p "$INSTALL_DIR/var/cache/netdata" \
         "$INSTALL_DIR/var/lib/netdata" \
         "$INSTALL_DIR/var/log/netdata"

"$INSTALL_DIR/usr/sbin/netdata" \
  -c "$INSTALL_DIR/etc/netdata/netdata.conf" \
  -D \
  -W set global "cache directory" "$INSTALL_DIR/var/cache/netdata" \
  -W set global "lib directory"   "$INSTALL_DIR/var/lib/netdata" \
  -W set global "log directory"   "$INSTALL_DIR/var/log/netdata"

echo "✅ AC OK!"

📡 V2AP（基地台一鍵安裝）

會自動把 hostname 寫入 netdata.conf

set -e

# 判斷 runtime
if [ -e /lib/ld-linux-aarch64.so.1 ]; then
  RUNTIME=glibc
elif [ -e /lib/ld-musl-aarch64.so.1 ]; then
  RUNTIME=musl
else
  echo "❌ Unsupported runtime"
  exit 1
fi
echo "✅ Runtime: $RUNTIME"

# 選擇安裝路徑
if [ -d /data ] && touch /data/.rw 2>/dev/null; then
  rm -f /data/.rw
  ROOT=/data
else
  ROOT=/tmp
fi

INSTALL_DIR="$ROOT/netdata_v2_ap"
PKG="netdata-ap-aarch64-${RUNTIME}.tar.gz"
URL="https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/${PKG}"

cd /tmp
curl -k -L -o ap.tar.gz "$URL" || wget --no-check-certificate -O ap.tar.gz "$URL"

rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
tar -xzf ap.tar.gz -C "$INSTALL_DIR"

MY_NAME="$(hostname)"
sed -i "s/REPLACEME_HOSTNAME/$MY_NAME/" \
  "$INSTALL_DIR/etc/netdata/netdata.conf" || true

chmod +x "$INSTALL_DIR/usr/sbin/netdata"
mkdir -p "$INSTALL_DIR/var/cache/netdata" \
         "$INSTALL_DIR/var/lib/netdata" \
         "$INSTALL_DIR/var/log/netdata"

"$INSTALL_DIR/usr/sbin/netdata" \
  -c "$INSTALL_DIR/etc/netdata/netdata.conf" \
  -D \
  -W set global "cache directory" "$INSTALL_DIR/var/cache/netdata" \
  -W set global "lib directory"   "$INSTALL_DIR/var/lib/netdata" \
  -W set global "log directory"   "$INSTALL_DIR/var/log/netdata"

echo "✅ AP OK!"

🔍 常見問題

看到 No such file or directory 但檔案存在？
👉 99% 是 glibc / musl 不匹配，本 README 已自動處理。

為什麼不能 tar -C /？
👉 很多設備 / 是唯讀（squashfs）。

Web UI
👉 http://設備IP:19999
