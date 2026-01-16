# 🚀 Netdata V2 自動化佈署工具 (aarch64)

這是針對嵌入式設備（AP/AC 控制器）優化的 Netdata V2 瘦身版。支援 `curl` 與 `wget` 雙緩衝下載，並自動處理 SSL 憑證問題。

# 🚀 REX FAE TOOL - Netdata V2

## 🛠️ V2AC（控制器一鍵安裝）
```bash
cd /tmp && \
(curl -k -L -o ac.tar.gz https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/netdata-controller-aarch64.tar.gz || \
 wget --no-check-certificate -O ac.tar.gz https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/netdata-controller-aarch64.tar.gz) && \
tar -xzf ac.tar.gz -C / && \
chmod +x /usr/sbin/netdata && \
/usr/sbin/netdata && \
echo AC_OK
```

## 📡 V2AP（基地台一鍵安裝）
```bash
cd /tmp && (curl -k -L -o ap.tar.gz "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/netdata-ap-aarch64.tar.gz" || wget --no-check-certificate -O ap.tar.gz "https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/Netdata2/aarch64/netdata-ap-aarch64.tar.gz") && tar -zxvf ap.tar.gz -C / && MY_NAME=$(hostname) && sed -i "s/REPLACEME_HOSTNAME/$MY_NAME/" /etc/netdata/netdata.conf && chmod +x /usr/sbin/netdata && /usr/sbin/netdata && echo "✅ AP OK!"
```

