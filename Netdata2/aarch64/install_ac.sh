#!/bin/sh
# AC 控制器安裝腳本 - Netdata V2 (aarch64)
RAW_URL="https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64"
cd /tmp

echo "--- 正在下載 AC 控制器組件 ---"
(curl -k -L -o ac.tar.gz "${RAW_URL}/netdata-controller-aarch64.tar.gz" || wget --no-check-certificate -O ac.tar.gz "${RAW_URL}/netdata-controller-aarch64.tar.gz")

echo "--- 正在解壓安裝 ---"
tar -zxvf ac.tar.gz -C /

echo "--- 修正權限與啟動服務 ---"
chmod +x /usr/lib/netdata/plugins.d/*
chmod +x /usr/sbin/netdata
/usr/sbin/netdata

echo -e "\n\n======================================================"
echo -e "✅ AC 控制器 Netdata 安裝完成！"
echo -e "🌐 請訪問控制台介面: http://[AC_IP]:19999"
echo -e "⚙️  接收 Port: 19999 (預設已開啟串流接收)"
echo -e "======================================================\n"