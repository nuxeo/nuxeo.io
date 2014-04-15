#!/bin/sh

/opt/data/tools/wait-container.sh $VBLOB_NAME

PORT=`docker port $VBLOB_NAME 9981 | awk -F : '{print $2}'`

/opt/data/tools/register-service.sh $S3_SERVICE $PORT
