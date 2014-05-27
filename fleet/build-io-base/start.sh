#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

cd /opt/data && sudo git pull --rebase
/usr/bin/docker build --no-cache -t nuxeo/iobase /opt/data/docker/io-base/

# Tag and push iobase on registry
/usr/bin/docker tag nuxeo/iobase $REGISTRY/nuxeo/iobase
/usr/bin/docker push $REGISTRY/nuxeo/iobase

echo "image pushed"
