#!/bin/sh


REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

docker images | grep  "^nuxeo/iobase"
if [ ! $? -eq 0 ]; then
  echo "building image..."
  /usr/bin/docker build -t nuxeo/iobase /opt/data/docker/io-base/
fi
# Tag and push iobase on registry
/usr/bin/docker tag nuxeo/iobase $REGISTRY/nuxeo/iobase
/usr/bin/docker push $REGISTRY/nuxeo/iobase

echo "image pushed"
