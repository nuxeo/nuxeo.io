#!/bin/sh

DOCKER_REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

PG_PWD=`openssl rand -base64 20`
/usr/bin/docker run --rm -P -t --name ${ENV_TECH_ID} --link ${POSTGRES_AMB}:db -e PG_DB_NAME=${ENV_TECH_ID} -e PG_ROLE_NAME=${ENV_TECH_ID} -e PG_PWD=${PG_PWD} -e ENV_TECH_ID=${ENV_TECH_ID} ${DOCKER_REGISTRY}/nuxeo/iocontainer
