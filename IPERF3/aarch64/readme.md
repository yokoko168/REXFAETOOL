# Static Binary iperf3 (AArch64)

針對嵌入式系統 (如 OpenWrt/Linux AP) 優化的靜態編譯版本，不需額外依賴庫即可執行。
此腳本具備自動判斷功能，優先使用 curl，若失敗則自動切換 wget，確保在各種韌體版本皆可下載。

## 🖥️ 1. Server 端 (接收端)

請複製執行以下指令，系統會自動清理舊檔、下載新檔、授權並直接啟動 Server 模式：

```bash
cd /root && rm -f iperf3 && (curl -k -L -o iperf3 "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3)" || wget --no-check-certificate -O iperf3 "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3)") && chmod +x iperf3 && echo "✅ 安裝完成，正在啟動 iperf3 Server..." && ./iperf3 -s

💻 2. Client 端 (發送端 / FAE 專用)
請複製執行以下指令，下載後會顯示 參數速查表 與 範例指令，方便現場修改 IP：

cd /root && rm -f iperf3 && (curl -k -L -o iperf3 "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3)" || wget --no-check-certificate -O iperf3 "[https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3](https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3)") && chmod +x iperf3 && echo -e "\n\n======================================================\n✅ 安裝完成！參數速查表：\n\n  -c [ServerIP] : 指定 Server IP (必填)\n  -u            : 使用 UDP 模式 (測 WiFi 建議用)\n  -b [頻寬]     : 限制頻寬 (例: 4M, 100M, 0=無限)\n  -t [秒數]     : 測試時間 (例: 10, 20)\n  -P [數量]     : 平行連線數 (多流測試, 例: 4)\n  -R            : 反向模式 (Server 傳給 Client, 測下行)\n  -B [本機IP]   : 綁定本機特定網卡 IP\n  -f m          : 顯示單位改為 Mbits\n\n⬇️  請複製底下範例去修改：\n./iperf3 -c 192.168.1.1 -u -b 100M -P 2 -t 20 -f m\n======================================================\n"
