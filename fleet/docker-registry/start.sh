#!/bin/sh

/usr/bin/docker ps --all | grep ${REGISTRY_NAME}
if [ ! $? -eq 0 ]; then
  /usr/bin/docker run -p 5000 --name ${REGISTRY_NAME} registry:0.6.5
else
  /usr/bin/docker restart ${REGISTRY_NAME}
fi
