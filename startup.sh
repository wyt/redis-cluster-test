#!/usr/bin/env bash

current_path=`pwd`
nodes=(7000  7001  7002  7003  7004  7005)

for val in "${nodes[@]}"
do
    path=$current_path/$val
    echo $path
    cd $path
    ../redis-3.2.13/bin/redis-server redis.conf
done

ps -elf | grep -v 'grep' | grep redis


# 以下命令执行时,最终只能启动成功一个redis实例,原因待查
#./redis-3.2.13/bin/redis-server 7000/redis.conf
#./redis-3.2.13/bin/redis-server 7001/redis.conf
#./redis-3.2.13/bin/redis-server 7002/redis.conf
#./redis-3.2.13/bin/redis-server 7003/redis.conf
#./redis-3.2.13/bin/redis-server 7004/redis.conf
#./redis-3.2.13/bin/redis-server 7005/redis.conf
