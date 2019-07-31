# reids-cluster-test


###

``` bash

[root@localhost bin]# pwd
/usr/local/reids-cluster-test/redis-3.2.13/bin
[root@localhost bin]# git clone https://github.com/wyt/reids-cluster-test.git
[root@localhost bin]# chmod +x ./*
```


``` bash
# 安装ruby环境
yum install centos-release-scl-rh
yum install rh-ruby23 -y
# 当前session生效
scl enable rh-ruby23 bash
ruby -v

[root@pseudo-cluster bin]# gem install redis
Fetching: redis-4.1.2.gem (100%)
Successfully installed redis-4.1.2
Parsing documentation for redis-4.1.2
Installing ri documentation for redis-4.1

[root@pseudo-cluster bin]# ./redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005
>>> Creating cluster
>>> Performing hash slots allocation on 6 nodes...
Using 3 masters:
127.0.0.1:7000
127.0.0.1:7001
127.0.0.1:7002
Adding replica 127.0.0.1:7003 to 127.0.0.1:7000
Adding replica 127.0.0.1:7004 to 127.0.0.1:7001
Adding replica 127.0.0.1:7005 to 127.0.0.1:7002
M: c8d905ab36662ee532e153fe078ded652d29f944 127.0.0.1:7000
   slots:0-5460 (5461 slots) master
M: 8ac9d5388d8d288c12f8bab8e3da6d969c55374d 127.0.0.1:7001
   slots:5461-10922 (5462 slots) master
M: 7d9b01ec9474b89bf1fe35c0106fd60667836316 127.0.0.1:7002
   slots:10923-16383 (5461 slots) master
S: 6ae00956436fa1ceb4eafcd82c3846bd8edeb51a 127.0.0.1:7003
   replicates c8d905ab36662ee532e153fe078ded652d29f944
S: d2e7b6edb4dcf238aadca19e87c3509c2283a121 127.0.0.1:7004
   replicates 8ac9d5388d8d288c12f8bab8e3da6d969c55374d
S: d9c33c0ffbb65b3177885f5307f68d66b7a15fec 127.0.0.1:7005
   replicates 7d9b01ec9474b89bf1fe35c0106fd60667836316
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join.
>>> Performing Cluster Check (using node 127.0.0.1:7000)
M: c8d905ab36662ee532e153fe078ded652d29f944 127.0.0.1:7000
   slots:0-5460 (5461 slots) master
   1 additional replica(s)
M: 8ac9d5388d8d288c12f8bab8e3da6d969c55374d 127.0.0.1:7001
   slots:5461-10922 (5462 slots) master
   1 additional replica(s)
S: d9c33c0ffbb65b3177885f5307f68d66b7a15fec 127.0.0.1:7005
   slots: (0 slots) slave
   replicates 7d9b01ec9474b89bf1fe35c0106fd60667836316
S: d2e7b6edb4dcf238aadca19e87c3509c2283a121 127.0.0.1:7004
   slots: (0 slots) slave
   replicates 8ac9d5388d8d288c12f8bab8e3da6d969c55374d
S: 6ae00956436fa1ceb4eafcd82c3846bd8edeb51a 127.0.0.1:7003
   slots: (0 slots) slave
   replicates c8d905ab36662ee532e153fe078ded652d29f944
M: 7d9b01ec9474b89bf1fe35c0106fd60667836316 127.0.0.1:7002
   slots:10923-16383 (5461 slots) master
   1 additional replica(s)
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered..2
Done installing documentation for redis after 1 seconds
1 gem installed
```

``` bash
[root@pseudo-cluster bin]# ./redis-cli -c -p 7000
127.0.0.1:7000> set foo bar
-> Redirected to slot [12182] located at 127.0.0.1:7002
OK
127.0.0.1:7002> set hello world
-> Redirected to slot [866] located at 127.0.0.1:7000
OK
127.0.0.1:7000> set name sunwukong
-> Redirected to slot [5798] located at 127.0.0.1:7001
OK
127.0.0.1:7001> get foo
-> Redirected to slot [12182] located at 127.0.0.1:7002
"bar"
127.0.0.1:7002> get name
-> Redirected to slot [5798] located at 127.0.0.1:7001
"sunwukong"
127.0.0.1:7001> get hello
-> Redirected to slot [866] located at 127.0.0.1:7000
"world"
127.0.0.1:7000> 
```