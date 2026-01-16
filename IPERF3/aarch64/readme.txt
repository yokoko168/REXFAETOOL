static binary iperf 


wget --no-check-certificate -O /root/iperf3 "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/IPERF3/aarch64/iperf3" && chmod +x /root/iperf3 && echo "安裝完成，正在啟動 iperf3 Server..." && /root/iperf3 -s



下載：把檔案存到 /root/iperf3。

權限：chmod +x 讓它變成可執行檔。

啟動：直接執行 /root/iperf3 -s (Server 模式)。
