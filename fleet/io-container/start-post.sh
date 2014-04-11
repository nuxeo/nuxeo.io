#!/bin/sh
# Waiting for io docker container up
while ! docker ps | grep -q $ENV_TECH_ID
do
    sleep 2
done
IP=`/opt/data/tools/resolve-ip.sh`
PORT=`docker port $ENV_TECH_ID 8080 | awk -F : '{print $2}'`

/usr/bin/etcdctl set /services/$ENV_TECH_ID/1/location \{\"host\":\"$IP\",\"port\":$PORT\}
