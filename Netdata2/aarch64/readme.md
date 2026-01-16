# 🚀 Netdata V2 自動化佈署工具 (aarch64)

這是針對嵌入式設備（AP/AC 控制器）優化的 Netdata V2 瘦身版。支援 `curl` 與 `wget` 雙緩衝下載，並自動處理 SSL 憑證問題。

---

## 🛠️ 控制器端 (AC/Parent) 安裝指令
適用於 **EWS5203** 等控制器。安裝後會開啟 Port 19999 並自動進入接收模式。

```bash
(curl -k -L "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ac.sh](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ac.sh)" | sh) || (wget --no-check-certificate -O- "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ac.sh](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ac.sh)" | sh)


##📡 基地台端 (AP/Child) 安裝指令
適用於 EAP105 等 AP 設備。安裝後將以「無頭模式 (Headless)」運作，不佔用本地儲存與 Web 資源，直接將數據串流至 AC。

```bash
(curl -k -L "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ap.sh](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ap.sh)" | sh) || (wget --no-check-certificate -O- "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ap.sh](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ap.sh)" | sh)

##💡 FAE 現場檢查小撇步
檢查服務狀態：執行 ps | grep netdata

AC 端檢查連線節點：執行 netdatacli list-nodes (應顯示 70 台 AP 名稱)

查看 Web 介面：瀏覽器打開 http://[AC_IP]:19999

---

### 如何更新到 GitHub？

在你的 Mac 終端機執行：

```bash
# 1. 進入目錄
cd /opt/homebrew/Cellar/webdav/5.10.0/bin/git_FAETOOL/NETDATA/netdata瘦身包AP_AC_ok_v2/Netdata2/aarch64

# 2. 編輯或建立 readme.md (貼上上面的內容)
# 你可以用 VS Code 或直接用指令:
# pbpaste > readme.md (如果你已經複製了上面的內容)

# 3. 推送至 GitHub
cd ../..
git add .
git commit -m "Update README with one-click copy UI"
git push origin main
