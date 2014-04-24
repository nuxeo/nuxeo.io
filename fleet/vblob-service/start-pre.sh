#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

docker images | grep  "^nuxeo/vblob"
if [ ! $? -eq 0 ]; then
  echo "building image..."
  # Build vblob image
  /usr/bin/docker build -t nuxeo/vblob /opt/data/docker/vblob/
fi

# Tag and push container on registry
/usr/bin/docker tag nuxeo/vblob $REGISTRY/nuxeo/vblob
/usr/bin/docker push $REGISTRY/nuxeo/vblob

echo "image pushed"
