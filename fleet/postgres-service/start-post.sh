#!/bin/sh

/opt/data/tools/wait-container.sh $POSTGRES_NAME
PORT=`docker port $POSTGRES_NAME 5432 | awk -F : '{print $2}'`

/opt/data/tools/register-service.sh $POSTGRES_NAME $PORT
