#!/bin/sh

/usr/bin/docker pull arken/passivator
/usr/bin/docker run --rm --name $PASSIVATOR_NAME arken/passivator
echo "Container $PASSIVATOR_NAME is running."
