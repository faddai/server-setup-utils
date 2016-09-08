#!/bin/sh

curl -sSL http://download.redis.io/releases/redis-stable.tar.gz -o /tmp/redis.tar.gz
mkdir -p /tmp/redis
tar -xzf /tmp/redis.tar.gz -C /tmp/redis --strip-components=1
make -C /tmp/redis
make -C /tmp/redis install
echo -n | /tmp/redis/utils/install_server.sh
rm -rf /tmp/redis*

# See: http://redis.io/topics/faq
sysctl vm.overcommit_memory=1

# Bind Redis to localhost. Comment out to make available externally.
sed -ie 's/# bind 127.0.0.1/bind 127.0.0.1/g' /etc/redis/6379.conf
service redis_6379 restart