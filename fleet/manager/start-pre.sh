#!/bin/sh

REGISTRY=`/usr/bin/etcdctl get /docker/registry`

docker images | grep  "^nuxeo/manager"
if [ ! $? -eq 0 ]; then
  echo "building image..."
  /usr/bin/docker build -t nuxeo/manager /opt/data/docker/manager/
fi
# Tag and push container on registry
/usr/bin/docker tag nuxeo/manager $REGISTRY/nuxeo/manager
/usr/bin/docker push $REGISTRY/nuxeo/manager

echo "image pushed"

POSTGRES_NAME=postgres-service
PGPASSWORD=nxiopostgres
PG_HOST=`/usr/bin/etcdctl get /service/$POSTGRES_NAME/1/host`
PG_PORT=`/usr/bin/etcdctl get /service/$POSTGRES_NAME/1/port`

psql -h $PG_HOST -p $PG_PORT -U postgres -t template1 -c '\du' | grep $MANAGER_NAME
if [ ! $? -eq 0 ]; then
  psql -h $PG_HOST -p $PG_PORT -U postgres -t template1 --quiet -t -f-" << EOF > /dev/null
    CREATE USER $MANAGER_NAME;
    CREATE DATABASE $MANAGER_NAME ENCODING 'UTF8' OWNER $MANAGER_NAME;
EOF
fi

