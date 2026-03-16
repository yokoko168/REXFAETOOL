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
