# 🚀 REX FAE TOOL - Netdata V2 (aarch64)

此專案提供 **aarch64** 的 Netdata V2 一鍵安裝：
- ✅ 同時支援 **glibc** 與 **musl**
- ✅ 自動偵測系統 runtime（`ld-linux` / `ld-musl`）
- ✅ 自動選擇安裝路徑（優先 `/data`，若不存在則使用 `/tmp`）
- ✅ 控制器（V2AC）/ 基地台（V2AP）兩種角色

> ⚠️ 注意：若你的系統根目錄 `/`（包含 `/usr`、`/lib`）是唯讀，請勿嘗試解壓到 `/`。
> 本 README 會自動改用 `/data`（永久）或 `/tmp`（暫存）。

---

## 📦 檔案命名規則（請你在 GitHub 放這些檔案）

請把對應檔案上傳到：

`Netdata2/aarch64/`

### 控制器（AC）
- `netdata-controller-aarch64-glibc.tar.gz`
- `netdata-controller-aarch64-musl.tar.gz`

### 基地台（AP）
- `netdata-ap-aarch64-glibc.tar.gz`
- `netdata-ap-aarch64-musl.tar.gz`

---

## 🛠️ V2AC（控制器一鍵安裝｜自動判斷 glibc / musl）

```bash
set -e

# 1) runtime 偵測
if [ -e /lib/ld-linux-aarch64.so.1 ]; then
  RUNTIME="glibc"
elif [ -e /lib/ld-musl-aarch64.so.1 ]; then
  RUNTIME="musl"
else
  echo "❌ Unknown runtime loader. Need glibc or musl for aarch64."
  exit 1
fi
echo "✅ Runtime: $RUNTIME"

# 2) 安裝路徑（優先永久 /data，其次 /tmp）
if [ -d /data ] && (touch /data/.rw_test 2>/dev/null); then
  rm -f /data/.rw_test
  INSTALL_ROOT="/data"
else
  INSTALL_ROOT="/tmp"
fi
INSTALL_DIR="$INSTALL_ROOT/netdata_v2_ac"
echo "✅ Install dir: $INSTALL_DIR"

# 3) 下載 + 解壓（解到可寫位置）
cd /tmp
PKG="netdata-controller-aarch64-${RUNTIME}.tar.gz"
URL="https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/${PKG}"

echo "⬇️ Download: $PKG"
(curl -k -L -o ac.tar.gz "$URL" || wget --no-check-certificate -O ac.tar.gz "$URL")

rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
tar -xzf ac.tar.gz -C "$INSTALL_DIR"

# 4) 啟動（完全不依賴寫入 /usr）
chmod +x "$INSTALL_DIR/usr/sbin/netdata"

mkdir -p "$INSTALL_DIR/var/cache/netdata" "$INSTALL_DIR/var/lib/netdata" "$INSTALL_DIR/var/log/netdata"

"$INSTALL_DIR/usr/sbin/netdata" \
  -c "$INSTALL_DIR/etc/netdata/netdata.conf" \
  -D \
  -W set global "cache directory" "$INSTALL_DIR/var/cache/netdata" \
  -W set global "lib directory" "$INSTALL_DIR/var/lib/netdata" \
  -W set global "log directory" "$INSTALL_DIR/var/log/netdata"

echo "✅ AC OK!"
echo "🌐 Web UI: http://$(hostname -I 2>/dev/null | awk '{print $1}'):${NETDATA_PORT:-19999}  (default 19999)"
```

---

## 📡 V2AP（基地台一鍵安裝｜自動判斷 glibc / musl）

```bash
set -e

# 1) runtime 偵測
if [ -e /lib/ld-linux-aarch64.so.1 ]; then
  RUNTIME="glibc"
elif [ -e /lib/ld-musl-aarch64.so.1 ]; then
  RUNTIME="musl"
else
  echo "❌ Unknown runtime loader. Need glibc or musl for aarch64."
  exit 1
fi
echo "✅ Runtime: $RUNTIME"

# 2) 安裝路徑（優先永久 /data，其次 /tmp）
if [ -d /data ] && (touch /data/.rw_test 2>/dev/null); then
  rm -f /data/.rw_test
  INSTALL_ROOT="/data"
else
  INSTALL_ROOT="/tmp"
fi
INSTALL_DIR="$INSTALL_ROOT/netdata_v2_ap"
echo "✅ Install dir: $INSTALL_DIR"

# 3) 下載 + 解壓（解到可寫位置）
cd /tmp
PKG="netdata-ap-aarch64-${RUNTIME}.tar.gz"
URL="https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/${PKG}"

echo "⬇️ Download: $PKG"
(curl -k -L -o ap.tar.gz "$URL" || wget --no-check-certificate -O ap.tar.gz "$URL")

rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"
tar -xzf ap.tar.gz -C "$INSTALL_DIR"

# 4) 套用 hostname 到 netdata.conf（你原本的需求）
MY_NAME="$(hostname)"
sed -i "s/REPLACEME_HOSTNAME/$MY_NAME/" "$INSTALL_DIR/etc/netdata/netdata.conf" || true

# 5) 啟動（完全不依賴寫入 /usr）
chmod +x "$INSTALL_DIR/usr/sbin/netdata"

mkdir -p "$INSTALL_DIR/var/cache/netdata" "$INSTALL_DIR/var/lib/netdata" "$INSTALL_DIR/var/log/netdata"

"$INSTALL_DIR/usr/sbin/netdata" \
  -c "$INSTALL_DIR/etc/netdata/netdata.conf" \
  -D \
  -W set global "cache directory" "$INSTALL_DIR/var/cache/netdata" \
  -W set global "lib directory" "$INSTALL_DIR/var/lib/netdata" \
  -W set global "log directory" "$INSTALL_DIR/var/log/netdata"

echo "✅ AP OK!"
echo "🌐 Web UI: http://$(hostname -I 2>/dev/null | awk '{print $1}'):${NETDATA_PORT:-19999}  (default 19999)"
```

---

## 🔍 常見問題

### Q1：為什麼原本 `tar -C /` 會失敗？
因為很多嵌入式系統 `/`（含 `/usr`、`/lib`）是唯讀（squashfs），會出現 `Read-only file system`。

### Q2：出現 `No such file or directory` 但檔案明明存在？
通常是 **runtime loader 不相容**：
- glibc 系統需要 `interpreter /lib/ld-linux-aarch64.so.1`
- musl 系統需要 `interpreter /lib/ld-musl-aarch64.so.1`

本 README 已自動偵測並下載對應版本。

### Q3：重開機後還在嗎？
- 安裝到 `/data`：✅ 通常會保留（永久）
- 安裝到 `/tmp`：❌ 多半會消失（暫存）
