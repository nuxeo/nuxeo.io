#!/bin/sh

docker kill $MANAGER_NAME
/opt/data/tools/docker-clean.sh $MANAGER_NAME &> /dev/null
