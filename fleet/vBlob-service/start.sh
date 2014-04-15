#!/bin/sh

REGISTRY=`/usr/bin/etcdctl get /docker/registry`

/usr/bin/docker run -v /opt/binaries:/opt/binaries:rw --rm -P --name ${VBLOB_NAME} ${REGISTRY}/nuxeo/vblob
