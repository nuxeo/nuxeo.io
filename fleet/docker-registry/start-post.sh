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

/usr/bin/etcdctl set /docker/registry $REGISTRY_IP:$REGISTRY_PORT

docker images | grep  "^nuxeo/iocontainer"
if [ ! $? -eq 0 ]; then
  echo "building image..."
  /usr/bin/docker build -t nuxeo/iocontainer /opt/data/docker/io-container/
fi
# Tag and push container on registry
/usr/bin/docker tag nuxeo/iocontainer $REGISTRY_IP:$REGISTRY_PORT/nuxeo/iocontainer
/usr/bin/docker push $REGISTRY_IP:$REGISTRY_PORT/nuxeo/iocontainer

echo "image pushed"
