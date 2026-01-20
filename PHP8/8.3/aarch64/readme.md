

php-8.3.30-cli-linux-aarch64.tar.gz >>php*




rex@reM2 fuck % curl -L -O https://dl.static-php.dev/static-php-cli/bulk/php-8.3.30-cli-linux-aarch64.tar.gz
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0
100   670    0   670    0     0    309      0 --:--:--  0:00:02 --:--:--   309
100 29.4M  100 29.4M    0     0  2329k      0  0:00:12  0:00:12 --:--:-- 4683k
rex@reM2 fuck % ls -lh php-8.3.30-cli-linux-aarch64.tar.gz
-rw-r--r--  1 rex  staff    29M  1月 20 22:29 php-8.3.30-cli-linux-aarch64.tar.gz
rex@reM2 fuck % tar -zxvf php-8.3.30-cli-linux-aarch64.tar.gz
x php
rex@reM2 fuck % ls -F php
php*
rex@reM2 fuck % scp -O -J rex@192.168.194.252 php root@192.168.11.2:/mnt/php_build/



Last login: Tue Jan 20 23:03:10 on ttys001
rex@reM2 aarch64 % pwd
/private/tmp/REXFAETOOL/PHP8/8.3/aarch64
rex@reM2 aarch64 % tree
.
├── php
├── php-8.3.30-cli-linux-aarch64.tar.gz
└── readme.md

1 directory, 3 files
rex@reM2 aarch64 % git add php php-8.3.30-cli-linux-aarch64.tar.gz readme.md
git status  # 確認無未追蹤檔案

位於分支 main
您的分支與上游分支 'origin/main' 一致。

您處於稀疏簽出狀態，包含 20% 的追蹤檔案。

沒有要提交的檔案，工作區為乾淨狀態
rex@reM2 aarch64 % git commit -m "Add PHP 8.3.30 aarch64 files"
git push origin main

[main 857ace6] Add PHP 8.3.30 aarch64 files
 Committer: rex <rex@reM2.local>
您的姓名和信件位址皆根據您的使用者名稱和主機名稱自動設定。
請檢查是否正確。您可以自行設定，這樣便不會再出現這個提示訊息：

    git config --global user.name "Your Name"
    git config --global user.email you@example.com

設定完畢後，您可以使用下述指令，修正這個提交使用的提交者身份：

    git commit --amend --reset-author

 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100755 PHP8/8.3/aarch64/php
 create mode 100644 PHP8/8.3/aarch64/php-8.3.30-cli-linux-aarch64.tar.gz
枚舉物件: 11, 完成.
正在計算物件數量: 100% (11/11), 完成.
使用 10 個執行緒進行壓縮
壓縮物件中: 100% (6/6), 完成.
寫入物件中: 100% (7/7), 58.86 MiB | 7.51 MiB/s, 完成.
總共 7 (差異 1)，復用 0 (差異 0)，重用包 0 (總共 0)
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/yokoko168/REXFAETOOL.git
   ff68c60..857ace6  main -> main
rex@reM2 aarch64 % 

