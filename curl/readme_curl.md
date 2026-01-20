curl binary
https://github.com/stunnel/static-curl/releases/tag/8.18.0



方案 A：利用 opkg 幫你抓第一個「梯子」 (最推薦)
既然你的系統有 opkg (Entware)，我們先用它裝一個支援 HTTPS 的 wget，然後再用它去抓你的專屬工具。

Bash
cd /mnt/php_build/rextool

# 1. 更新軟體源並安裝支援 SSL 的 wget (這會自動處理 HTTPS 問題)
opkg update
opkg install wget-ssl

# 2. 現在系統有強大的 wget 了，直接下載你的 curl
/opt/bin/wget --no-check-certificate https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/curl/curl -O curl

# 3. 賦予執行權限並測試
chmod +x curl
./curl -V


一旦你成功把自己的 curl 抓下來（記得檢查 ls -lh curl 大小是否正確，不要又是 9 bytes），請立即執行：

Bash
# 1. 確保它是執行檔
chmod +x /mnt/php_build/rextool/curl

# 2. 用你的 curl 下載 SSL 憑證 (解決 PHP spc 下載時的 Error 77)
/mnt/php_build/rextool/curl -k -L https://curl.se/ca/cacert.pem -o /mnt/php_build/cacert.pem

# 3. 設定環境變數並開工
export SSL_CERT_FILE=/mnt/php_build/cacert.pem
export PATH=/mnt/php_build/rextool:$PATH

cd /mnt/php_build
./spc download --with-php=8.3 --all


第一步：補齊系統缺失的憑證 (CA Bundle)
你的新 curl 雖然強大，但它還是需要一份「信任名單」來驗證 GitHub。我們立刻下載它：

Bash
cd /mnt/php_build/rextool

# 使用你的新 curl 下載憑證檔 (-k 代表忽略目前的憑證檢查)
./curl -k -L https://curl.se/ca/cacert.pem -o /mnt/php_build/cacert.pem

# 檢查檔案大小 (正常應該在 200KB 左右)
ls -lh /mnt/php_build/cacert.pem

第二步：啟動「Rex 工具箱」環境變數
這是最關鍵的一步，讓 spc 知道去哪裡找工具和憑證。請執行這幾行：

Bash
# 1. 讓目前的 SSH 視窗優先使用你的新 curl 和工具
export PATH=/mnt/php_build/rextool:$PATH

# 2. 告訴所有程式 (特別是 spc) 憑證在哪裡
export CURL_CA_BUNDLE=/mnt/php_build/cacert.pem
export SSL_CERT_FILE=/mnt/php_build/cacert.pem

# 3. 驗證 (應該指到你的新路徑)
which curl


現在回到你的 9GB 大空間，啟動 spc 計畫：

Bash
cd /mnt/php_build

# 確保 spc 權限正確
chmod +x spc

# 開始下載 (現在 spc 就不會再報 Error 77 了，它會透過你的環境變數找到憑證)
./spc download --with-php=8.3 --all


一旦 download 跑完（大約下載 128 個原始碼包），你就可以進行最後的編譯：

Bash
# 等 download 完後才執行：
./spc build "bcmath,calendar,ctype,curl,dom,filter,gd,mbstring,openssl,pcntl,pdo_mysql,phar,session,simplexml,tokenizer,xml,xmlreader,xmlwriter,zip,zlib" --build-cli -L
⚠️ FAE 的小禮物：預防重啟消失
因為 /root 在 RAM 裡，你辛苦下載的 curl 要是放在 /root 會不見。但我看你已經把它存在 /mnt/php_build/rextool 了，這很正確！

你的 ./spc download 是否已經開始跑進度條了？ 只要看到 [1/128] 出現，你就可以先去巡一下別的機台，讓它在背景慢慢跑了。
