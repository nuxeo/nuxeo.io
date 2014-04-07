#!/bin/sh

/usr/bin/docker ps --all | grep ${POSTGRES_NAME}
if [ ! $? -eq 0 ]; then
  /usr/bin/docker run -p 22 --name ${POSTGRES_NAME} nuxeo/postgres
else
  /usr/bin/docker restart ${POSTGRES_NAME}
fi
