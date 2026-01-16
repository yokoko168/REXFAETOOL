# 🚀 Netdata V2 自動化佈署工具 (aarch64)

這是針對嵌入式設備（AP/AC 控制器）優化的 Netdata V2 瘦身版。支援 `curl` 與 `wget` 雙緩衝下載，並自動處理 SSL 憑證問題。

---

## 🛠️ 控制器端 (AC/Parent) 安裝指令
適用於 **EWS5203** 等控制器。安裝後會開啟 Port 19999 並自動進入接收模式。

```bash
(curl -k -L "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ac.sh](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ac.sh)" | sh) || (wget --no-check-certificate -O- "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ac.sh](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/install_ac.sh)" | sh)
