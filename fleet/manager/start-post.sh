#!/bin/sh
# Waiting for io docker container up
while ! docker ps | grep -q $MANAGER_NAME
do
    sleep 2
done

PORT=`docker port $MANAGER_NAME 8080 | awk -F : '{print $2}'`
/opt/data/tools/register-service.sh $MANAGER_NAME $PORT

DOMAIN=`/usr/bin/etcdctl get /services/manager/config/domain`
/usr/bin/etcdctl set /domains/$DOMAIN/type service
/usr/bin/etcdctl set /domains/$DOMAIN/value manager


