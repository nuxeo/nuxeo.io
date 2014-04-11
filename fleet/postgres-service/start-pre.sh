#!/bin/sh

REGISTRY=`/usr/bin/etcdctl get /docker/registry`

# Build postgres image
/usr/bin/docker build -t nuxeo/postgres /opt/data/docker/postgres/

# Tag and push container on registry
/usr/bin/docker tag nuxeo/postgres $REGISTRY/nuxeo/postgres
/usr/bin/docker push $REGISTRY/nuxeo/postgres

echo "image pushed"
