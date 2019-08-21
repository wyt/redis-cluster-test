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
