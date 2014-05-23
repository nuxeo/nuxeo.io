#!/bin/sh

/opt/data/tools/wait-container.sh $ENV_TECH_ID
IP=`/opt/data/tools/resolve-ip.sh`
PORT=`docker port $ENV_TECH_ID 8080 | awk -F : '{print $2}'`

/usr/bin/etcdctl set /services/$ENV_TECH_ID/1/location \{\"host\":\"$IP\",\"port\":$PORT\}
