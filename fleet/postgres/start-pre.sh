#!/bin/sh

REGISTRY=`/usr/bin/etcdctl get /docker/registry`

docker images | grep  "^nuxeo/postgres"
if [ ! $? -eq 0 ]; then
  echo "building image..."
  /usr/bin/docker build -t nuxeo/postgres /opt/data/docker/postgres/
fi
# Tag and push container on registry
/usr/bin/docker tag nuxeo/postgres $REGISTRY/nuxeo/postgres
/usr/bin/docker push $REGISTRY/nuxeo/postgres

echo "image pushed"
