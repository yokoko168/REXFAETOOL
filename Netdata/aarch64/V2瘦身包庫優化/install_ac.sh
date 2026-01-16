#!/bin/sh
RAW_URL="https://raw.githubusercontent.com/您的帳號/您的倉庫名/main"
cd /tmp
echo "--- 下載 AC 控制器版 ---"
wget ${RAW_URL}/netdata-controller-aarch64.tar.gz -O ac.tar.gz
echo "--- 解壓安裝 ---"
tar -zxvf ac.tar.gz -C /
echo "--- 啟動服務 ---"
chmod +x /usr/lib/netdata/plugins.d/*
chmod +x /usr/sbin/netdata
/usr/sbin/netdata
echo "✅ AC 控制器已就緒 (Port 19999)"
