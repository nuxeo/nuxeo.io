#!/bin/sh -

DB_PORT_1337_TCP_ADDR=`etcdctl get /services/postgres-service/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1/'`
DB_PORT_1337_TCP_PORT=`etcdctl get /services/postgres-service/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\2/'`

/usr/bin/docker pull quay.io/nuxeoio/postgres-cleaner
/usr/bin/docker run --rm --name postgres-cleaner-${SERVICE_ID} \
  -e DB_PORT_1337_TCP_ADDR="${DB_PORT_1337_TCP_ADDR}" -e DB_PORT_1337_TCP_PORT="${DB_PORT_1337_TCP_PORT}" \
  -e PG_DB_NAME="${SERVICE_ID}" -e PG_ROLE_NAME="${SERVICE_ID}" \
  -e PGPASSWORD="nuxeoiopostgres" \
  quay.io/nuxeoio/postgres-cleaner
