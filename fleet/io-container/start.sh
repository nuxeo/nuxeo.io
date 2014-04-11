#!/bin/sh

POSTGRES_NAME=postgres-service
PGPASSWORD=nxiopostgres
POSTGRES_AMB=postgres-amb
PG_PWD=`openssl rand -base64 20`
PG_HOST=`/usr/bin/etcdctl get /service/$POSTGRES_NAME/1/host`
PG_PORT=`/usr/bin/etcdctl get /service/$POSTGRES_NAME/1/port`

psql -h $PG_HOST -p $PG_PORT -U postgres -t template1 --quiet -t -f-" << EOF > /dev/null
    ALTER USER $ENV_TECH_ID WITH PASSWORD '$PG_PWD';
EOF

/usr/bin/docker run -P -t --name ${ENV_TECH_ID} --link ${POSTGRES_AMB}:db -e PG_PWD=${PG_PWD} -e ENV_TECH_ID=${ENV_TECH_ID} ${DOCKER_REGISTRY}/nuxeo/iocontainer
