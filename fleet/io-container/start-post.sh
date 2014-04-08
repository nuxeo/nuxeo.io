#!/bin/sh
# Waiting for io docker container up
while ! docker ps | grep -q $ENV_TECH_ID
do
    sleep 2
done
IP=`/opt/data/tools/resolve-ip.sh`
PORT=`docker port $ENV_TECH_ID 8080 | awk -F : '{print $2}'`

/usr/bin/etcdctl set /envs/$ENV_TECH_ID/port $PORT
/usr/bin/etcdctl set /envs/$ENV_TECH_ID/ip $IP
/usr/bin/etcdctl set /envs/$ENV_TECH_ID/location \{\"host\":\"$IP\",\"port\":$PORT\}
