#!/bin/sh

IP=`/opt/data/tools/resolve-ip.sh`
PORT=`docker port $POSTGRES_NAME 5432 | awk -F : '{print $2}'`

/usr/bin/etcdctl set /services/$POSTGRES_NAME/1 \{\"host\":\"$IP\",\"port\":$PORT\}
