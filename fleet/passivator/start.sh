#!/bin/sh

/opt/data/tools/docker-clean.sh ${PASSIVATOR_NAME} &> /dev/null

/usr/bin/docker pull arken/passivator:0.1.0
/usr/bin/docker run --rm --name $PASSIVATOR_NAME arken/passivator:0.1.0
echo "Container $PASSIVATOR_NAME is running."
