#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

/usr/bin/docker build --no-cache -t nuxeo/iobase /opt/data/docker/io-base/

# Tag and push iobase on registry
/usr/bin/docker tag nuxeo/iobase $REGISTRY/nuxeo/iobase
exec /usr/bin/docker push $REGISTRY/nuxeo/iobase
