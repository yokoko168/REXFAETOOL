

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
