#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

# Build postgres image
/usr/bin/docker build -t nuxeo/vblob /opt/data/docker/vBlob/

# Tag and push container on registry
/usr/bin/docker tag nuxeo/vblob $REGISTRY/nuxeo/vblob
/usr/bin/docker push $REGISTRY/nuxeo/vblob

echo "image pushed"
