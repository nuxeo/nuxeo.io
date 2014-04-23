#!/bin/sh

POSTGRES_AMB=postgres-amb
PG_PWD=`openssl rand -hex 15`
/usr/bin/docker run --rm -P -t --name ${ENV_TECH_ID} --link ${POSTGRES_AMB}:db -e PG_DB_NAME=${ENV_TECH_ID} -e PG_ROLE_NAME=${ENV_TECH_ID} -e PG_PWD=${PG_PWD} -e ENV_TECH_ID=${ENV_TECH_ID} -e PGPASSWORD=nuxeoiopostgres ${DOCKER_REGISTRY}/nuxeo/iocontainer
