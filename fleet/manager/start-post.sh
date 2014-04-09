#!/bin/sh
# Waiting for io docker container up
while ! docker ps | grep -q $MANAGER_NAME
do
    sleep 2
done

/usr/bin/etcdctl set /domains/$MANAGER_DOMAIN/type uri
/usr/bin/etcdctl set /domains/$MANAGER_DOMAIN/value http://`/opt/data/tools/resolve-ip.sh`:`docker port $MANAGER_NAME 8080 | awk -F : '{print $2}'`
