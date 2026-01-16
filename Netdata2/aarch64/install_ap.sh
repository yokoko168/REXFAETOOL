#!/bin/sh
# AP 瘦身版安裝腳本 - Netdata V2 (aarch64)
RAW_URL="https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64"
cd /tmp

echo "--- 正在下載 AP 版 Netdata ---"
(curl -k -L -o ap.tar.gz "${RAW_URL}/netdata-ap-aarch64.tar.gz" || wget --no-check-certificate -O ap.tar.gz "${RAW_URL}/netdata-ap-aarch64.tar.gz")

echo "--- 正在安裝 ---"
tar -zxvf ap.tar.gz -C /

echo "--- 配置 Hostname ---"
MY_NAME=$(hostname)
sed -i "s/REPLACEME_HOSTNAME/$MY_NAME/" /etc/netdata/netdata.conf

echo "--- 啟動服務 ---"
chmod +x /usr/lib/netdata/plugins.d/*
chmod +x /usr/sbin/netdata
/usr/sbin/netdata

echo -e "\n\n======================================================"
echo -e "✅ AP ($MY_NAME) Netdata 安裝完成！"
echo -e "📡 數據模式: 無頭模式 (Headless / Memory mode = none)"
echo -e "📤 串流目標: 腳本預設 AC IP (請確認 stream.conf 正確)"
echo -e "🔍 檢查連線: netdatacli list-nodes (在 AC 端下指令)"
echo -e "======================================================\n"