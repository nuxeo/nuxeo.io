#!/bin/sh
# Waiting for io docker container up
while ! docker ps | grep -q $ENV_TECH_ID
do
    sleep 2
done

/usr/bin/etcdctl set /envs/$ENV_TECH_ID/port `docker port $ENV_TECH_ID 8080 | awk -F : '{print $2}'`
/usr/bin/etcdctl set /envs/$ENV_TECH_ID/ip `/opt/data/tools/resolve-ip.sh`
