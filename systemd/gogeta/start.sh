#!/bin/sh

/usr/bin/docker pull arken/gogeta
/usr/bin/docker run --rm --name $GOGETA_NAME -p 7777:7777 arken/gogeta
echo "Container $GOGETA_NAME is running."
