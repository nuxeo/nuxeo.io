#!/bin/sh

/usr/bin/docker ps --all | grep ${POSTGRES_NAME}
if [ ! $? -eq 0 ]; then
  /usr/bin/docker run -v /opt/db:/opt/db:rw --rm -P --name ${POSTGRES_NAME} nuxeo/postgres
else
  /usr/bin/docker restart ${POSTGRES_NAME}
fi
