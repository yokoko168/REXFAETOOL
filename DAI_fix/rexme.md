cd /tmp || exit 1

# 下載
curl -k -L -O https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/DAI_fix/dai-mini.tar.gz || exit 1

# 解壓到系統
tar -zxvf dai-mini.tar.gz -C / || exit 1

# 權限修正
chmod 755 /etc/firewall.dai /etc/init.d/cipfwd /sbin/cipfwd || exit 1

# 重啟服務
killall cipfwd 2>/dev/null || true
/etc/init.d/cipfwd stop 2>/dev/null || true

# 套用 DAI 規則
sh /etc/firewall.dai

# 啟動
/etc/init.d/cipfwd start

# 驗證
ps | grep -E 'cipfwd|ulog' | grep -v grep

很好，這個我幫你整理成「可以對主管交代 + 可直接用」的版本。

---

# ✅ 一鍵安裝指令（正式版）

## 單行版（你原本風格）

```sh
cd /tmp && curl -k -L -O https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/DAI_fix/dai-mini.tar.gz && tar -zxvf dai-mini.tar.gz -C / && chmod 755 /etc/firewall.dai /etc/init.d/cipfwd /sbin/cipfwd && killall cipfwd 2>/dev/null || true; /etc/init.d/cipfwd stop 2>/dev/null || true; sh /etc/firewall.dai && /etc/init.d/cipfwd start && ps | grep -E 'cipfwd|ulog' | grep -v grep
```

---

## 可讀版（建議 README 用）

```sh
cd /tmp || exit 1

# 下載
curl -k -L -O https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/DAI_fix/dai-mini.tar.gz || exit 1

# 解壓到系統
tar -zxvf dai-mini.tar.gz -C / || exit 1

# 權限修正
chmod 755 /etc/firewall.dai /etc/init.d/cipfwd /sbin/cipfwd || exit 1

# 重啟服務
killall cipfwd 2>/dev/null || true
/etc/init.d/cipfwd stop 2>/dev/null || true

# 套用 DAI 規則
sh /etc/firewall.dai

# 啟動
/etc/init.d/cipfwd start

# 驗證
ps | grep -E 'cipfwd|ulog' | grep -v grep
```

---

# 📘 README.md（你可以直接貼）

## DAI Fix 一鍵安裝

此工具用於修復 AP 上缺失的 DAI（DHCP Snooping + ARP Inspection）機制，
恢復 client IP 學習與 UI 顯示能力。

---

## 🔧 安裝方式（One-liner）

```sh
cd /tmp && curl -k -L -O https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/DAI_fix/dai-mini.tar.gz && tar -zxvf dai-mini.tar.gz -C / && chmod 755 /etc/firewall.dai /etc/init.d/cipfwd /sbin/cipfwd && killall cipfwd 2>/dev/null || true; /etc/init.d/cipfwd stop 2>/dev/null || true; sh /etc/firewall.dai && /etc/init.d/cipfwd start
```

---

## 📦 安裝內容

本套件包含：

* `/etc/firewall.dai`
  → DAI 主邏輯（ebtables 規則 + DHCP/ARP 學習）

* `/etc/init.d/cipfwd`
  → DAI 控制服務腳本

* `/sbin/cipfwd`
  → 使用者空間 daemon（負責解析 ulog / 建立 DAI_status）

---

## 🧠 原理說明（重點，給主管用）

### 1️⃣ 為什麼 AP 看不到 client IP？

在 AP 架構中：

* client 的 DHCP request 是 **L2 bridge 轉發**
* AP 本身**不是 DHCP server**
* 所以：

  * AP ARP table ≠ 全部 client
  * `arp -a` 不會有所有使用者

👉 這是「正常現象」，不是 bug

---

### 2️⃣ DAI 的作用

DAI（Dynamic ARP Inspection）做了三件事：

#### ✔ DHCP Snooping

攔截 DHCP 封包，學習：

```
MAC → IP
```

#### ✔ ARP Inspection

驗證 ARP 是否與 DHCP 綁定一致（防 ARP spoofing）

#### ✔ Userspace Learning（關鍵）

透過：

* `ebtables --ulog`
* `ulog-listener`
* `cipfwd`

建立：

```
/tmp/DAI_status
```

👉 UI 顯示的 IP 就是來自這裡

---

### 3️⃣ 為什麼你現在「有 IP 但 ARP 沒資料」？

因為：

| 項目         | 狀態        |
| ---------- | --------- |
| ARP table  | ❌ 不完整（正常） |
| DAI_status | ✅ 完整      |
| UI 顯示      | ✅ 正確      |

👉 結論：

> AP 顯示 IP 是靠 DAI，不是 ARP

---

### 4️⃣ 這次修復做了什麼？

修復內容：

* 補回 `firewall.dai`
* 補回 `cipfwd`
* 重建 ebtables pipeline
* 啟動 ulog → userspace learning

---

## ✅ 驗證方式

### 1️⃣ 確認 daemon

```sh
ps | grep -E 'cipfwd|ulog'
```

應看到：

```
/sbin/ulog-listener
/sbin/cipfwd
```

---

### 2️⃣ 確認 DAI 學習

```sh
cat /tmp/DAI_status
```

應看到：

```json
"MAC": { "ip": "192.168.x.x" }
```

---

### 3️⃣ UI 應恢復 IP 顯示

✔ client list 有 IP
✔ 不再出現「連線但沒 IP」

---

## ⚠️ 注意事項

* 此機制 **不依賴 ARP table**
* 不需要 client 主動 ARP
* 適用於 bridge / tunnel / NAT 架構

---

## 🧩 與舊版差異

| 功能            | 舊 firmware | 現在    |
| ------------- | ---------- | ----- |
| DAI           | ✅          | ❌（遺失） |
| DHCP Snooping | ✅          | ❌     |
| UI IP 顯示      | ✅          | ❌     |
| 本修復           | → 恢復       |       |

---

# 🧠 幫你講給主管聽的一句話版本

你可以直接這樣說：

> AP 本身是 L2 bridge，不會自然學到所有 client IP。
> 我們透過 DAI（DHCP Snooping + ARP Inspection）在 userspace 建立 IP/MAC 對應，
> UI 顯示的 IP 是來自這個機制，而不是 ARP table。
> 這次問題是 firmware 少了 DAI 模組，現在已經補回並正常運作。

---

如果你要，我可以再幫你做：

✅ UI 顯示來源 tracing（哪個 lua / js 在讀 DAI_status）
✅ 或幫你做「完整 firmware patch 包」一鍵補齊全部功能（含 modules）
