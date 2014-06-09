#!/bin/sh

/opt/data/tools/docker-clean.sh ${GOGETA_NAME} &> /dev/null

/usr/bin/docker pull arken/gogeta
/usr/bin/docker run --rm --name $GOGETA_NAME -p 7777:7777 arken/gogeta
echo "Container $GOGETA_NAME is running."
