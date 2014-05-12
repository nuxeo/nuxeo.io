#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`
/usr/bin/docker run -v /opt/db:/opt/db:rw --rm -P --name ${POSTGRES_NAME} ${REGISTRY}/nuxeo/postgres
