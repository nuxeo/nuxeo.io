#!/bin/sh

echo "deploy-iocontainer"

# Wait until fleet is started
sleep 5

docker ps | grep $REGISTRY_NAME
if [ ! $? -eq 0 ]; then
  echo "Unable to find $REGISTRY_NAME container"
  exit 1
fi

REGISTRY_PORT=`docker port $REGISTRY_NAME 5000 | awk -F : '{print $2}'`
REGISTRY_IP=`/opt/data/tools/resolve-ip.sh`

echo "put registry information in etcd"


/usr/bin/etcdctl set /services/docker-registry/1 \{\"host\":\"$REGISTRY_IP\",\"port\":$REGISTRY_PORT\}
