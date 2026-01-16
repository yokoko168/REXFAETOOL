static binary iperf 


wget --no-check-certificate -O /root/iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3" && chmod +x /root/iperf3 && echo "安裝完成，正在啟動 iperf3 Server..." && /root/iperf3 -s

下載：把檔案存到 /root/iperf3。
權限：chmod +x 讓它變成可執行檔。
啟動：直接執行 /root/iperf3 -s (Server 模式)。





cd /root && wget --no-check-certificate -O iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3" && chmod +x iperf3 && echo -e "\n\n======================================================\n✅ 安裝完成！參數速查表：\n\n  -c [ServerIP] : 指定 Server IP (必填)\n  -u            : 使用 UDP 模式 (測 WiFi 建議用)\n  -b [頻寬]     : 限制頻寬 (例: 4M, 100M, 0=無限)\n  -t [秒數]     : 測試時間 (例: 10, 20)\n  -P [數量]     : 平行連線數 (多流測試, 例: 4)\n  -R            : 反向模式 (Server 傳給 Client, 測下行)\n  -B [本機IP]   : 綁定本機特定網卡 IP\n  -f m          : 顯示單位改為 Mbits\n\n⬇️  請複製底下範例去修改：\n./iperf3 -c 192.168.Server.IP -u -b 100M -P 2 -t 20 -f m\n======================================================\n"
