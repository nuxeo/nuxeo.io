#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

cd /opt/data && sudo git pull --rebase

# postgres-cleaner
/usr/bin/docker build --no-cache -t nuxeo/postgres-cleaner /opt/data/docker/postgres-cleaner/
# Tag and push iobase on registry
/usr/bin/docker tag nuxeo/postgres-cleaner $REGISTRY/nuxeo/postgres-cleaner
/usr/bin/docker push $REGISTRY/nuxeo/postgres-cleaner

# s3-cleaner
##/usr/bin/docker build --no-cache -t nuxeo/s3-cleaner /opt/data/docker/s3-cleaner/
# Tag and push iobase on registry
##/usr/bin/docker tag nuxeo/s3-cleaner $REGISTRY/nuxeo/s3-cleaner
##/usr/bin/docker push $REGISTRY/nuxeo/s3-cleaner

echo "Cleaners pushed."
