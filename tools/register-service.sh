#!/bin/sh -

if [ $# -lt 2 ]; then
  echo "Usage: $0 SERVICE_NAME SERVICE_PORT [SERVICE_IP]"
  exit 1
fi

SERVICE_NAME=$1
SERVICE_PORT=$2
if [ $# -gt 2 ]; then
  SERVICE_IP=$3
else
  SERVICE_IP=`/opt/data/tools/resolve-ip.sh`
fi

/usr/bin/etcdctl set /services/$SERVICE_NAME/1/location \{\"host\":\"$SERVICE_IP\",\"port\":$SERVICE_PORT\}
