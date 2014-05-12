#!/bin/sh

/opt/data/tools/wait-container.sh $REGISTRY_NAME
/opt/data/tools/register-service.sh $REGISTRY_NAME 5000
