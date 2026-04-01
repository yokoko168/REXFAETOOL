# 1. 解壓實體檔案到 /usr/lib/
tar -zxvf sftp-install.tar.gz -C / usr/lib/sftp-server

# 2. 解壓符號連結到 /usr/libexec/
tar -zxvf sftp-install.tar.gz -C / usr/libexec/sftp-server

# 3. 修正擁有者與權限
chown root:root /usr/lib/sftp-server /usr/libexec/sftp-server
chmod 755 /usr/lib/sftp-server


SFTP 這樣就可以直接用了
curl -k -L -O https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/SFTP/aarch64/sftp-install.tar.gz
tar -zxvf sftp-install.tar.gz -C / usr/lib/sftp-server
tar -zxvf sftp-install.tar.gz -C / usr/libexec/sftp-server
tar -zxvf sftp-install.tar.gz -C / usr/libexec/sftp-server
chown root:root /usr/lib/sftp-server /usr/libexec/sftp-server
chmod 755 /usr/lib/sftp-server


eap105  修覆一鍵安裝，2026年4月1日
cd /tmp || exit 1
curl -k -L -O https://github.com/yokoko168/REXFAETOOL/raw/refs/heads/main/SFTP/aarch64/sftp-install.tar.gz || exit 1
tar -zxvf sftp-install.tar.gz -C / || exit 1
rm -f /usr/._.DS_Store /usr/.DS_Store /usr/._lib /usr/._libexec /usr/lib/._sftp-server /usr/libexec/._sftp-server /._usr 2>/dev/null || true
chown root:root /usr/lib/sftp-server /usr/libexec/sftp-server || exit 1
chmod 755 /usr/lib/sftp-server /usr/libexec/sftp-server || exit 1
ls -l /usr/lib/sftp-server /usr/libexec/sftp-server
