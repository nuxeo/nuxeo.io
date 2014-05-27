#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

/usr/bin/docker build --no-cache -t nuxeo/iocontainer /opt/data/docker/io-container/

# Tag and push iocontainer on registry
/usr/bin/docker tag nuxeo/iocontainer $REGISTRY/nuxeo/iocontainer
/usr/bin/docker push $REGISTRY/nuxeo/iocontainer

echo "image pushed"
