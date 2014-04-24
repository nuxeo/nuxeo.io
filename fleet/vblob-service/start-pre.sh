#!/bin/sh

REGISTRY=`/usr/bin/etcdctl get /docker/registry`

# Build postgres image
/usr/bin/docker build -t nuxeo/vblob /opt/data/docker/vblob/

# Tag and push container on registry
/usr/bin/docker tag nuxeo/vblob $REGISTRY/nuxeo/vblob
/usr/bin/docker push $REGISTRY/nuxeo/vblob

echo "image pushed"
