#!/bin/sh

REGISTRY=`/usr/bin/etcdctl get /docker/registry`

docker images | grep  "^nuxeo/manager"
if [ ! $? -eq 0 ]; then
  echo "building image..."
  /usr/bin/docker build -t nuxeo/manager /opt/data/docker/manager/
fi
# Tag and push container on registry
/usr/bin/docker tag nuxeo/manager $REGISTRY/nuxeo/manager
/usr/bin/docker push $REGISTRY/nuxeo/manager

echo "image pushed"
