curl -fL -o /tmp/qga-bundle.tar.gz "https://raw.githubusercontent.com/yokoko168/REXFAETOOL/main/%E8%80%81%E8%88%B9%E5%B9%AB%E5%B9%AB%E5%BF%99/pve_guest_agetn/qga-bundle.tar.gz"

curl -fL -o /tmp/install-guest.sh "https://raw.githubusercontent.com/yokoko168/REXFAETOOL/main/%E8%80%81%E8%88%B9%E5%B9%AB%E5%B9%AB%E5%BF%99/pve_guest_agetn/install-guest.sh"

curl -fL -o /tmp/install-pve.sh "https://raw.githubusercontent.com/yokoko168/REXFAETOOL/main/%E8%80%81%E8%88%B9%E5%B9%AB%E5%B9%AB%E5%BF%99/pve_guest_agetn/install-pve.sh"


用pve下載再推到vm
curl -fL -o /tmp/qga-bundle.tar.gz "https://raw.githubusercontent.com/yokoko168/REXFAETOOL/main/%E8%80%81%E8%88%B9%E5%B9%AB%E5%B9%AB%E5%BF%99/pve_guest_agetn/qga-bundle.tar.gz"
# 2) 丟到 VEWS（Active）
scp /tmp/qga-bundle.tar.gz /tmp/install-guest.sh  /tmp/install-pve.sh root@192.168.11.22:/tmp/

合成版+修正 -O 會強制使用舊 scp protocol，不需要 sftp-server。
  scp -O -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
  /tmp/qga-bundle.tar.gz /tmp/install-guest.sh /tmp/install-pve.sh \
  root@192.168.11.22:/tmp/

  再傳到副機
  scp -O -r "/Users/rex/EWS5203_level_build/pve_agent_self-bu/qga-bundle" root@192.168.11.22:/opt/

  scp -O -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
  /tmp/qga-bundle.tar.gz /tmp/install-guest.sh /tmp/install-pve.sh \
  root@172.31.0.2:/tmp/


  版本 1：最簡單（小檔/大檔都能用）

在來源端（Active）：

cat /tmp/install-guest.sh | ssh root@172.31.0.2 'cat > /tmp/install-guest.sh'
cat /tmp/install-pve.sh   | ssh root@172.31.0.2 'cat > /tmp/install-pve.sh'
cat /tmp/qga-bundle.tar.gz | ssh root@172.31.0.2 'cat > /tmp/qga-bundle.tar.gz'
ssh root@172.31.0.2 'chmod +x /tmp/install-guest.sh /tmp/install-pve.sh'

方法2
base64 /tmp/qga-bundle.tar.gz | ssh root@172.31.0.2 'base64 -d > /tmp/qga-bundle.tar.gz'
base64 /tmp/install-guest.sh  | ssh root@172.31.0.2 'base64 -d > /tmp/install-guest.sh'
base64 /tmp/install-pve.sh    | ssh root@172.31.0.2 'base64 -d > /tmp/install-pve.sh'


