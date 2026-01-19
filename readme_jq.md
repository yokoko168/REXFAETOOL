cd /tmp && curl -k -L -o jq "https://raw.githubusercontent.com/yokoko168/REXFAETOOL/main/jq/jq-linux-arm64" && chmod +x jq && ./jq --version


df -h 確認 /overlay 或 / 的 Available 至少還有 10MB 以上比較保險。
which jq確認系統原本有沒有內建同名的工具。


最保險的做法：放在 /root
mkdir -p /root/tools
mv /tmp/jq /root/tools/
chmod +x /root/tools/jq
# 將這個目錄加入系統路徑（暫時性，重啟後失效，但對原生系統最安全）
export PATH=$PATH:/root/tools


# 1. 將 jq 從 tmp 移動到 /usr/bin
mv /tmp/jq /usr/bin/
chmod +x /usr/bin/jq
# 2. 測試是否能在任何地方執行（不用 ./）
cd / && jq --version
