#!/bin/sh -

if [ $# -lt 2 ]; then
    echo "Usage: $0 DOMAIN SERVICE"
    exit 1
fi

DOMAIN=$1
SERVICE=$2

/usr/bin/etcdctl set /domains/$DOMAIN/type service
/usr/bin/etcdctl set /domains/$DOMAIN/value $SERVICE
