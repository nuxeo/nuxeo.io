#!/bin/sh

/usr/bin/docker run --rm --name $POSTGRES_AMB_NAME -P nuxeo/service-amb postgres-service
