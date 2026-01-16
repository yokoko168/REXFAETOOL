
netdata瘦身+包庫 % tree
.
├── etc
│   ├── fping.conf
│   ├── health_alarm_notify.conf
│   ├── init.d
│   │   └── netdata
│   ├── netdata
│   │   ├── charts.d
│   │   ├── custom-plugins.d
│   │   ├── ebpf.d
│   │   ├── edit-config
│   │   ├── go.d
│   │   ├── health.d
│   │   ├── netdata.conf
│   │   ├── node.d
│   │   ├── python.d
│   │   ├── ssl
│   │   ├── statsd.d
│   │   └── stream.conf
│   └── tc-qos-helper.sh
├── lib
│   └── upgrade
│       └── keep.d
│           └── netdata
├── netdata-final.tar.gz
└── usr
    ├── lib
    │   ├── libuuid.so.1 -> libuuid.so.1.3.0
    │   ├── libuuid.so.1.3.0
    │   ├── libuv.so.1 -> libuv.so.1.0.0
    │   ├── libuv.so.1.0.0
    │   └── netdata
    │       ├── charts.d
    │       │   ├── ap.chart.sh
    │       │   ├── apcupsd.chart.sh
    │       │   ├── example.chart.sh
    │       │   ├── libreswan.chart.sh
    │       │   ├── nut.chart.sh
    │       │   ├── opensips.chart.sh
    │       │   └── sensors.chart.sh
    │       ├── conf.d
    │       │   ├── apps_groups.conf
    │       │   ├── aws_kinesis.conf
    │       │   ├── charts.d
    │       │   │   ├── ap.conf
    │       │   │   ├── apcupsd.conf
    │       │   │   ├── example.conf
    │       │   │   ├── libreswan.conf
    │       │   │   ├── nut.conf
    │       │   │   ├── opensips.conf
    │       │   │   └── sensors.conf
    │       │   ├── charts.d.conf
    │       │   ├── ebpf.d
    │       │   │   ├── cachestat.conf
    │       │   │   ├── dcstat.conf
    │       │   │   ├── disk.conf
    │       │   │   ├── ebpf_kernel_reject_list.txt
    │       │   │   ├── fd.conf
    │       │   │   ├── filesystem.conf
    │       │   │   ├── hardirq.conf
    │       │   │   ├── mdflush.conf
    │       │   │   ├── mount.conf
    │       │   │   ├── network.conf
    │       │   │   ├── oomkill.conf
    │       │   │   ├── process.conf
    │       │   │   ├── shm.conf
    │       │   │   ├── softirq.conf
    │       │   │   ├── swap.conf
    │       │   │   ├── sync.conf
    │       │   │   └── vfs.conf
    │       │   ├── ebpf.d.conf
    │       │   ├── exporting.conf
    │       │   ├── fping.conf
    │       │   ├── health_alarm_notify.conf
    │       │   ├── health_email_recipients.conf
    │       │   ├── health.d
    │       │   │   ├── adaptec_raid.conf
    │       │   │   ├── anomalies.conf
    │       │   │   ├── apcupsd.conf
    │       │   │   ├── backend.conf
    │       │   │   ├── bcache.conf
    │       │   │   ├── beanstalkd.conf
    │       │   │   ├── bind_rndc.conf
    │       │   │   ├── boinc.conf
    │       │   │   ├── btrfs.conf
    │       │   │   ├── ceph.conf
    │       │   │   ├── cgroups.conf
    │       │   │   ├── cockroachdb.conf
    │       │   │   ├── cpu.conf
    │       │   │   ├── dbengine.conf
    │       │   │   ├── disks.conf
    │       │   │   ├── dns_query.conf
    │       │   │   ├── dnsmasq_dhcp.conf
    │       │   │   ├── dockerd.conf
    │       │   │   ├── entropy.conf
    │       │   │   ├── exporting.conf
    │       │   │   ├── fping.conf
    │       │   │   ├── fronius.conf
    │       │   │   ├── gearman.conf
    │       │   │   ├── geth.conf
    │       │   │   ├── go.d.plugin.conf
    │       │   │   ├── haproxy.conf
    │       │   │   ├── hdfs.conf
    │       │   │   ├── httpcheck.conf
    │       │   │   ├── ioping.conf
    │       │   │   ├── ipc.conf
    │       │   │   ├── ipfs.conf
    │       │   │   ├── ipmi.conf
    │       │   │   ├── isc_dhcpd.conf
    │       │   │   ├── kubelet.conf
    │       │   │   ├── linux_power_supply.conf
    │       │   │   ├── load.conf
    │       │   │   ├── mdstat.conf
    │       │   │   ├── megacli.conf
    │       │   │   ├── memcached.conf
    │       │   │   ├── memory.conf
    │       │   │   ├── mysql.conf
    │       │   │   ├── net.conf
    │       │   │   ├── netfilter.conf
    │       │   │   ├── pihole.conf
    │       │   │   ├── portcheck.conf
    │       │   │   ├── processes.conf
    │       │   │   ├── python.d.plugin.conf
    │       │   │   ├── qos.conf
    │       │   │   ├── ram.conf
    │       │   │   ├── redis.conf
    │       │   │   ├── retroshare.conf
    │       │   │   ├── riakkv.conf
    │       │   │   ├── scaleio.conf
    │       │   │   ├── softnet.conf
    │       │   │   ├── stiebeleltron.conf
    │       │   │   ├── swap.conf
    │       │   │   ├── synchronization.conf
    │       │   │   ├── systemdunits.conf
    │       │   │   ├── tcp_conn.conf
    │       │   │   ├── tcp_listen.conf
    │       │   │   ├── tcp_mem.conf
    │       │   │   ├── tcp_orphans.conf
    │       │   │   ├── tcp_resets.conf
    │       │   │   ├── timex.conf
    │       │   │   ├── udp_errors.conf
    │       │   │   ├── unbound.conf
    │       │   │   ├── vcsa.conf
    │       │   │   ├── vernemq.conf
    │       │   │   ├── vsphere.conf
    │       │   │   ├── web_log.conf
    │       │   │   ├── whoisquery.conf
    │       │   │   ├── wmi.conf
    │       │   │   ├── x509check.conf
    │       │   │   └── zfs.conf
    │       │   ├── ioping.conf
    │       │   ├── node.d.conf
    │       │   ├── python.d
    │       │   │   ├── adaptec_raid.conf
    │       │   │   ├── alarms.conf
    │       │   │   ├── am2320.conf
    │       │   │   ├── anomalies.conf
    │       │   │   ├── apache.conf
    │       │   │   ├── beanstalk.conf
    │       │   │   ├── bind_rndc.conf
    │       │   │   ├── boinc.conf
    │       │   │   ├── ceph.conf
    │       │   │   ├── changefinder.conf
    │       │   │   ├── chrony.conf
    │       │   │   ├── couchdb.conf
    │       │   │   ├── dns_query_time.conf
    │       │   │   ├── dnsdist.conf
    │       │   │   ├── dockerd.conf
    │       │   │   ├── dovecot.conf
    │       │   │   ├── elasticsearch.conf
    │       │   │   ├── energid.conf
    │       │   │   ├── example.conf
    │       │   │   ├── exim.conf
    │       │   │   ├── fail2ban.conf
    │       │   │   ├── freeradius.conf
    │       │   │   ├── gearman.conf
    │       │   │   ├── go_expvar.conf
    │       │   │   ├── haproxy.conf
    │       │   │   ├── hddtemp.conf
    │       │   │   ├── hpssa.conf
    │       │   │   ├── httpcheck.conf
    │       │   │   ├── icecast.conf
    │       │   │   ├── ipfs.conf
    │       │   │   ├── isc_dhcpd.conf
    │       │   │   ├── litespeed.conf
    │       │   │   ├── logind.conf
    │       │   │   ├── megacli.conf
    │       │   │   ├── memcached.conf
    │       │   │   ├── mongodb.conf
    │       │   │   ├── monit.conf
    │       │   │   ├── mysql.conf
    │       │   │   ├── nginx_plus.conf
    │       │   │   ├── nginx.conf
    │       │   │   ├── nsd.conf
    │       │   │   ├── ntpd.conf
    │       │   │   ├── nvidia_smi.conf
    │       │   │   ├── openldap.conf
    │       │   │   ├── oracledb.conf
    │       │   │   ├── ovpn_status_log.conf
    │       │   │   ├── phpfpm.conf
    │       │   │   ├── portcheck.conf
    │       │   │   ├── postfix.conf
    │       │   │   ├── postgres.conf
    │       │   │   ├── powerdns.conf
    │       │   │   ├── proxysql.conf
    │       │   │   ├── puppet.conf
    │       │   │   ├── rabbitmq.conf
    │       │   │   ├── redis.conf
    │       │   │   ├── rethinkdbs.conf
    │       │   │   ├── retroshare.conf
    │       │   │   ├── riakkv.conf
    │       │   │   ├── samba.conf
    │       │   │   ├── sensors.conf
    │       │   │   ├── smartd_log.conf
    │       │   │   ├── spigotmc.conf
    │       │   │   ├── springboot.conf
    │       │   │   ├── squid.conf
    │       │   │   ├── tomcat.conf
    │       │   │   ├── tor.conf
    │       │   │   ├── traefik.conf
    │       │   │   ├── uwsgi.conf
    │       │   │   ├── varnish.conf
    │       │   │   ├── w1sensor.conf
    │       │   │   ├── web_log.conf
    │       │   │   └── zscores.conf
    │       │   ├── python.d.conf
    │       │   ├── statsd.d
    │       │   │   ├── example.conf
    │       │   │   └── k6.conf
    │       │   └── stream.conf
    │       └── plugins.d
    │           ├── acl.sh
    │           ├── alarm-email.sh
    │           ├── alarm-notify.sh
    │           ├── alarm-test.sh
    │           ├── alarm.sh
    │           ├── anonymous-statistics.sh
    │           ├── apps.plugin
    │           ├── cgroup-name.sh
    │           ├── cgroup-network
    │           ├── cgroup-network-helper.sh
    │           ├── charts.d.dryrun-helper.sh
    │           ├── charts.d.plugin
    │           ├── fping.plugin
    │           ├── get-kubernetes-labels.sh
    │           ├── health-cmdapi-test.sh
    │           ├── ioping.plugin
    │           ├── loopsleepms.sh.inc
    │           ├── perf.plugin
    │           ├── request.sh
    │           ├── slabinfo.plugin
    │           ├── system-info.sh
    │           ├── tc-qos-helper.sh
    │           └── template_dim.sh
    ├── sbin
    │   └── netdata
    └── share
        └── netdata
            └── web

31 directories, 228 files
