#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

docker images | grep  "^nuxeo/manager"
if [ ! $? -eq 0 ]; then
  echo "building image..."
  # copy the coreos fleetctl binary for the manager
  cp /usr/bin/fleetctl /opt/data/docker/manager/fleetctl

  /usr/bin/docker build -t nuxeo/manager /opt/data/docker/manager/
fi
# Tag and push container on registry
/usr/bin/docker tag nuxeo/manager $REGISTRY/nuxeo/manager
/usr/bin/docker push $REGISTRY/nuxeo/manager

echo "image pushed"
