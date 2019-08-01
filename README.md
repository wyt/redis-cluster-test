# redis-cluster-test


#### 下载项目

``` bash
[root@pseudo-cluster local]# pwd
/usr/local
[root@pseudo-cluster local]# git clone https://github.com/wyt/redis-cluster-test.git
[root@pseudo-cluster bin]# pwd
/usr/local/redis-cluster-test/redis-3.2.13/bin
[root@pseudo-cluster bin]# chmod +x ./*
[root@pseudo-cluster redis-cluster-test]# pwd
/usr/local/redis-cluster-test
[root@pseudo-cluster redis-cluster-test]# chmod +x shutdown.sh startup.sh
```

#### 安装ruby环境等
``` bash
# 安装ruby环境
[root@pseudo-cluster redis-cluster-test] yum install centos-release-scl-rh
[root@pseudo-cluster redis-cluster-test] yum install rh-ruby23 -y
# 当前session生效
[root@pseudo-cluster redis-cluster-test] scl enable rh-ruby23 bash
[root@pseudo-cluster redis-cluster-test]# ruby -v
ruby 2.3.8p459 (2018-10-18 revision 65136) [x86_64-linux]
[root@pseudo-cluster redis-cluster-test]# gem install redis
Fetching: redis-4.1.2.gem (100%)
Successfully installed redis-4.1.2
Parsing documentation for redis-4.1.2
Installing ri documentation for redis-4.1
```

#### 规划集群

``` bash
[root@pseudo-cluster redis-cluster-test]# ls -lh
total 12K
drwxr-xr-x. 2 root root   80 Aug  1 18:07 7000
drwxr-xr-x. 2 root root   80 Aug  1 18:08 7001
drwxr-xr-x. 2 root root   80 Aug  1 18:07 7002
drwxr-xr-x. 2 root root   80 Aug  1 18:07 7003
drwxr-xr-x. 2 root root   80 Aug  1 18:08 7004
drwxr-xr-x. 2 root root   80 Aug  1 18:07 7005
-rw-r--r--. 1 root root 3.5K Aug  1 05:34 README.md
drwxr-xr-x. 3 root root   35 Aug  1 05:34 redis-3.2.13
-rwxr-xr-x. 1 root root   75 Aug  1 05:34 shutdown.sh
-rwxr-xr-x. 1 root root  635 Aug  1 05:34 startup.sh
[root@pseudo-cluster redis-cluster-test]# 
[root@pseudo-cluster redis-cluster-test]# 
[root@pseudo-cluster redis-cluster-test]# ./startup.sh 
/usr/local/redis-cluster-test/7000
/usr/local/redis-cluster-test/7001
/usr/local/redis-cluster-test/7002
/usr/local/redis-cluster-test/7003
/usr/local/redis-cluster-test/7004
/usr/local/redis-cluster-test/7005
5 S root      14589      1  0  80   0 - 35257 ep_pol 18:36 ?        00:00:00 ../redis-3.2.13/bin/redis-server *:7000 [cluster]
5 S root      14591      1  0  80   0 - 35257 ep_pol 18:36 ?        00:00:00 ../redis-3.2.13/bin/redis-server *:7001 [cluster]
5 S root      14595      1  0  80   0 - 35257 ep_pol 18:36 ?        00:00:00 ../redis-3.2.13/bin/redis-server *:7002 [cluster]
5 S root      14601      1  0  80   0 - 35257 ep_pol 18:36 ?        00:00:00 ../redis-3.2.13/bin/redis-server *:7003 [cluster]
5 S root      14605      1  0  80   0 - 35257 ep_pol 18:36 ?        00:00:00 ../redis-3.2.13/bin/redis-server *:7004 [cluster]
5 S root      14609      1  0  80   0 - 35257 ep_pol 18:36 ?        00:00:00 ../redis-3.2.13/bin/redis-server *:7005 [cluster]
[root@pseudo-cluster redis-cluster-test]# cd redis-3.2.13/bin
[root@pseudo-cluster bin]# ./redis-trib.rb create --replicas 1 192.168.91.146:7000 192.168.91.146:7001 192.168.91.146:7002 192.168.91.146:7003 192.168.91.146:7004 192.168.91.146:7005
>>> Creating cluster
>>> Performing hash slots allocation on 6 nodes...
Using 3 masters:
192.168.91.146:7000
192.168.91.146:7001
192.168.91.146:7002
Adding replica 192.168.91.146:7003 to 192.168.91.146:7000
Adding replica 192.168.91.146:7004 to 192.168.91.146:7001
Adding replica 192.168.91.146:7005 to 192.168.91.146:7002
M: c8d905ab36662ee532e153fe078ded652d29f944 192.168.91.146:7000
   slots:0-5460 (5461 slots) master
M: 8ac9d5388d8d288c12f8bab8e3da6d969c55374d 192.168.91.146:7001
   slots:5461-10922 (5462 slots) master
M: 7d9b01ec9474b89bf1fe35c0106fd60667836316 192.168.91.146:7002
   slots:10923-16383 (5461 slots) master
S: 6ae00956436fa1ceb4eafcd82c3846bd8edeb51a 192.168.91.146:7003
   replicates c8d905ab36662ee532e153fe078ded652d29f944
S: d2e7b6edb4dcf238aadca19e87c3509c2283a121 192.168.91.146:7004
   replicates 8ac9d5388d8d288c12f8bab8e3da6d969c55374d
S: d9c33c0ffbb65b3177885f5307f68d66b7a15fec 192.168.91.146:7005
   replicates 7d9b01ec9474b89bf1fe35c0106fd60667836316
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join.
>>> Performing Cluster Check (using node 192.168.91.146:7000)
M: c8d905ab36662ee532e153fe078ded652d29f944 192.168.91.146:7000
   slots:0-5460 (5461 slots) master
   1 additional replica(s)
M: 8ac9d5388d8d288c12f8bab8e3da6d969c55374d 192.168.91.146:7001
   slots:5461-10922 (5462 slots) master
   1 additional replica(s)
S: d9c33c0ffbb65b3177885f5307f68d66b7a15fec 192.168.91.146:7005
   slots: (0 slots) slave
   replicates 7d9b01ec9474b89bf1fe35c0106fd60667836316
S: d2e7b6edb4dcf238aadca19e87c3509c2283a121 192.168.91.146:7004
   slots: (0 slots) slave
   replicates 8ac9d5388d8d288c12f8bab8e3da6d969c55374d
S: 6ae00956436fa1ceb4eafcd82c3846bd8edeb51a 192.168.91.146:7003
   slots: (0 slots) slave
   replicates c8d905ab36662ee532e153fe078ded652d29f944
M: 7d9b01ec9474b89bf1fe35c0106fd60667836316 192.168.91.146:7002
   slots:10923-16383 (5461 slots) master
   1 additional replica(s)
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered..2
Done installing documentation for redis after 1 seconds
1 gem installed
```

#### 查看集群信息

``` bash
[root@pseudo-cluster redis-cluster-test]# ./redis-3.2.13/bin/redis-cli -c -p 7000
127.0.0.1:7000> CLUSTER INFO
cluster_state:ok
cluster_slots_assigned:16384
cluster_slots_ok:16384
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:6
cluster_size:3
cluster_current_epoch:6
cluster_my_epoch:1
cluster_stats_messages_sent:565
cluster_stats_messages_received:560
127.0.0.1:7000> CLUSTER NODES
02e7acff62564c7b013b91ef6be26229b59b1340 192.168.91.146:7002 master - 0 1564655935214 3 connected 10923-16383
b19247782173bcdc296a9a4c894ac4ebf0be06fe 192.168.91.146:7005 slave 02e7acff62564c7b013b91ef6be26229b59b1340 0 1564655936221 6 connected
4673cd4d0ba1cb1bfb382e330df1a94e3e98a304 192.168.91.146:7003 slave 447503405d564419262c1a7764abfd4574c57b64 0 1564655936725 4 connected
447503405d564419262c1a7764abfd4574c57b64 192.168.91.146:7000 myself,master - 0 0 1 connected 0-5460
f3d940b97d786abef6e5b6ee4ec44716c6a60b81 192.168.91.146:7001 master - 0 1564655936221 2 connected 5461-10922
f46e487d40fb43a70b51ecd15875f60e7201a5be 192.168.91.146:7004 slave f3d940b97d786abef6e5b6ee4ec44716c6a60b81 0 1564655935718 5 connected
127.0.0.1:7000> 
```

``` bash
[root@pseudo-cluster bin]# ./redis-cli -c -p 7000
192.168.91.146:7000> set foo bar
-> Redirected to slot [12182] located at 192.168.91.146:7002
OK
192.168.91.146:7002> set hello world
-> Redirected to slot [866] located at 192.168.91.146:7000
OK
192.168.91.146:7000> set name sunwukong
-> Redirected to slot [5798] located at 192.168.91.146:7001
OK
192.168.91.146:7001> get foo
-> Redirected to slot [12182] located at 192.168.91.146:7002
"bar"
192.168.91.146:7002> get name
-> Redirected to slot [5798] located at 192.168.91.146:7001
"sunwukong"
192.168.91.146:7001> get hello
-> Redirected to slot [866] located at 192.168.91.146:7000
"world"
192.168.91.146:7000> 
```