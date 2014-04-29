#!/bin/sh
# Waiting for io docker container up
while ! docker ps | grep -q $MANAGER_NAME
do
    sleep 2
done

DOMAIN=`/usr/bin/etcdctl get /services/manager/domain`
/usr/bin/etcdctl set /domains/$DOMAIN/type uri
/usr/bin/etcdctl set /domains/$DOMAIN/value http://`/opt/data/tools/resolve-ip.sh`:`docker port $MANAGER_NAME 8080 | awk -F : '{print $2}'`
