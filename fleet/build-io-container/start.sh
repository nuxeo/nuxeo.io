#!/bin/sh

REGISTRY=`/usr/bin/etcdctl get /docker/registry`

docker images | grep  "^nuxeo/iocontainer"
if [ ! $? -eq 0 ]; then
  echo "building image..."
  /usr/bin/docker build -t nuxeo/iocontainer /opt/data/docker/io-container/
fi
# Tag and push iocontainer on registry
/usr/bin/docker tag nuxeo/iocontainer $REGISTRY/nuxeo/iocontainer
/usr/bin/docker push $REGISTRY/nuxeo/iocontainer

echo "image pushed"
