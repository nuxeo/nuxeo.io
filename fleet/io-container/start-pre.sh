#!/bin/sh

/usr/bin/etcdctl set /envs/$ENV_TECH_ID/status/current starting

POSTGRES_NAME=postgres
PGPASSWORD=nxiopostgres
PG_HOST=`/usr/bin/etcdctl get /envs/$POSTGRES_NAME/ip`
PG_PORT=`/usr/bin/etcdctl get /envs/$POSTGRES_NAME/port`

psql -h $PG_HOST -p $PG_PORT -U postgres -t template1 -c '\du' | grep $ENV_TECH_ID
if [ ! $? -eq 0 ]; then
  psql -h $PG_HOST -p $PG_PORT -U postgres -t template1 --quiet -t -f-" << EOF > /dev/null
    CREATE USER $ENV_TECH_ID;
    CREATE DATABASE $ENV_TECH_ID ENCODING 'UTF8' OWNER $ENV_TECH_ID;
EOF
fi
