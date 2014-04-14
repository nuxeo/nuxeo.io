#!/bin/sh

POSTGRES_AMB=postgres-amb
while ! docker ps | grep -q $POSTGRES_AMB
do
    sleep 2
done

PG_PWD=`openssl rand -base64 20`
REGISTRY=`/usr/bin/etcdctl get /docker/registry`
/usr/bin/docker run --rm -P -t --name ${MANAGER_NAME} --link ${POSTGRES_AMB}:db -e PG_DB_NAME=${MANAGER_NAME} -e PG_ROLE_NAME=${MANAGER_NAME} -e PG_PWD=${PG_PWD} ${REGISTRY}/nuxeo/manager
