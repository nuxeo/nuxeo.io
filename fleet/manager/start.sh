#!/bin/sh

/usr/bin/docker ps --all | grep ${MANAGER_NAME}
if [ ! $? -eq 0 ]; then
  /usr/bin/docker run -p 22 -t -p 8080 --name ${MANAGER_NAME} nuxeo/manager
else
  /usr/bin/docker restart ${MANAGER_NAME}
fi
