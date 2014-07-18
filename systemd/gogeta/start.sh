#!/bin/sh

/opt/data/tools/docker-clean.sh ${GOGETA_NAME} &> /dev/null

/usr/bin/docker pull arken/gogeta:0.1.0
/usr/bin/docker run --rm --name $GOGETA_NAME -p 7777:7777 -v /opt/data/gogeta-templates:/gogeta-templates arken/gogeta:0.1.0 -templateDir /gogeta-templates
echo "Container $GOGETA_NAME is running."
