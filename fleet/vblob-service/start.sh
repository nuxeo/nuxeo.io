#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

/usr/bin/docker run -v /opt/binaries:/opt/binaries:rw --rm -P --name ${VBLOB_NAME} ${REGISTRY}/nuxeo/vblob
