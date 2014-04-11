#!/bin/sh

# Should be in a stopPre script but it doesn't exist
/usr/bin/etcdctl set /services/$ENV_TECH_ID/1/status/current stopping

# Sometimes, container seems not yet stopped
docker ps | grep $ENV_TECH_ID
if [ $? -eq 0 ]; then
  docker stop $ENV_TECH_ID
fi
docker rm $ENV_TECH_ID

docker ps -a | grep Exit | awk '{print $1}' | xargs docker rm
