#!/bin/sh

/opt/data/tools/wait-container.sh $REGISTRY_NAME
PORT=`docker port $REGISTRY_NAME 5000 | awk -F : '{print $2}'`
/opt/data/tools/register-service.sh $REGISTRY_NAME $PORT
