#!/bin/sh

/usr/bin/docker run -v /opt/db:/opt/db:rw --rm -P --name ${POSTGRES_NAME} quay.io/nuxeoio/postgres
