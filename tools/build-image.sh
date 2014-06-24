#!/bin/bash -

if [ $# -lt 1 ]; then
  echo "Usage: $0 DOCKER_IMAGE_NAME"
  exit 1
fi

# Build image
/usr/bin/docker build -t nuxeo/$1 /opt/data/docker/$1/

# Tag and push image on registry
/usr/bin/docker tag nuxeo/$1 $REGISTRY/nuxeo/$1
/usr/bin/docker push $REGISTRY/nuxeo/$1
