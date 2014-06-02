#!/bin/sh

/usr/bin/docker run -p 5000 --rm --name ${REGISTRY_NAME} registry:${REGISTRY_VERSION}
echo "Container $REGISTRY_NAME is running."
