#!/bin/sh -

POSTGRES_AMB=postgres-amb
REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

/usr/bin/docker pull $REGISTRY/nuxeo/postgres-cleaner
/usr/bin/docker run --rm --name postgres-cleaner-${SERVICE_ID} \
  --link ${POSTGRES_AMB}:db \
  -e PG_DB_NAME="${SERVICE_ID}" -e PG_ROLE_NAME="${SERVICE_ID}" \
  -e PGPASSWORD="nuxeoiopostgres" \
  $REGISTRY/nuxeo/postgres-cleaner
