#!/bin/sh
RAW_URL="https://raw.githubusercontent.com/您的帳號/您的倉庫名/main"
cd /tmp
echo "--- 下載 AP 瘦身版 ---"
wget ${RAW_URL}/netdata-ap-aarch64.tar.gz -O ap.tar.gz
echo "--- 解壓安裝 ---"
tar -zxvf ap.tar.gz -C /
echo "--- 配置 Hostname ---"
MY_NAME=$(hostname)
sed -i "s/REPLACEME_HOSTNAME/$MY_NAME/" /etc/netdata/netdata.conf
echo "--- 啟動服務 ---"
chmod +x /usr/lib/netdata/plugins.d/*
chmod +x /usr/sbin/netdata
/usr/sbin/netdata
echo "✅ AP ($MY_NAME) 已啟動並連向 AC"
