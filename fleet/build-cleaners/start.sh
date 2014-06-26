#!/bin/sh

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

/opt/data/tools/build-image.sh awscli
/opt/data/tools/build-image.sh postgres-cleaner

echo "Cleaners pushed."
