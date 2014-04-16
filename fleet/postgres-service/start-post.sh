#!/bin/sh

/opt/data/tools/wait-container.sh $POSTGRES_NAME
PORT=`docker port $POSTGRES_NAME 5432 | awk -F : '{print $2}'`

echo "Alive!?" | ncat 127.0.0.1 $PORT
/opt/data/tools/register-service.sh $POSTGRES_NAME $PORT
