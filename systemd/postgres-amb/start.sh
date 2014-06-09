#!/bin/sh

/opt/data/tools/docker-clean.sh ${POSTGRES_AMB_NAME} &> /dev/null

/usr/bin/docker pull arken/service-amb
/usr/bin/docker run --rm --name $POSTGRES_AMB_NAME -P arken/service-amb -servicePath /services/postgres-service
echo "Container $POSTGRES_AMB_NAME is running."
