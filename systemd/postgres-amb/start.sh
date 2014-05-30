#!/bin/sh

/usr/bin/docker run --rm --name $POSTGRES_AMB_NAME -P arken/service-amb -servicePath /services/postgres-service
