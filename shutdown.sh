#!/usr/bin/env bash

pkill -9 redis

ps -elf | grep -v 'grep' | grep redis
