#!/bin/sh

PG_PWD=`openssl rand -hex 15`
REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`
DB_PORT_1337_TCP_ADDR=`etcdctl get /services/postgres-service/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1/'`
DB_PORT_1337_TCP_PORT=`etcdctl get /services/postgres-service/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\2/'`
S3_BUCKET=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/config/s3/bucket`
S3_AWSID=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/config/s3/awsid`
S3_AWSSECRET=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/config/s3/awssecret`
S3_REGION=`/usr/bin/etcdctl get /_arken.io/config/s3/region`
DOMAIN=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/1/domain`
CLID=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/1/config/instance.clid`

ES_HOSTS=$(/usr/bin/etcdctl ls --recursive /services/elasticsearch \
             | grep transport  \
             | while read i; do etcdctl get $i \
             | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/';done \
             | paste -s -d",")

CONNECT_URL=`/usr/bin/etcdctl get /config/connect/url`
if [ ! $? -eq 0 ]; then
  CONNECT_URL=""
fi

HTTP_PROTOCOL=`/usr/bin/etcdctl get /_arken.io/config/http/protocol`
if [ ! $? -eq 0 ]; then
  HTTP_PROTOCOL="http"
fi

# Ensure to rm not correctly stopped container
/opt/data/tools/docker-clean.sh ${ENV_TECH_ID} &> /dev/null

# XXX To be removed as soon as we handle correctly target platform
CONTAINER_VERSION=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/config/platform`
if [ ! $? -eq 0 ]; then
  CONTAINER_VERSION=6.0
fi

PACKAGES=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/1/config/packages`
if [ ! $? -eq 0 ]; then
  PACKAGES="nuxeo-web-mobile nuxeo-drive nuxeo-diff nuxeo-spreadsheet nuxeo-dam nuxeo-template-rendering"
  if [ $CONTAINER_VERSION == "7.4" ]; then
    PACKAGES="$PACKAGES nuxeo-template-rendering-samples"
  fi
fi

/usr/bin/docker run --rm -P -t --name ${ENV_TECH_ID} \
  -e DB_PORT_1337_TCP_ADDR="${DB_PORT_1337_TCP_ADDR}" -e DB_PORT_1337_TCP_PORT="${DB_PORT_1337_TCP_PORT}" \
  -e PG_DB_NAME="${ENV_TECH_ID}" -e PG_ROLE_NAME="${ENV_TECH_ID}" -e PG_PWD="${PG_PWD}" \
  -e PGPASSWORD="nuxeoiopostgres" \
  -e S3_BUCKET="${S3_BUCKET}" -e S3_AWSID="${S3_AWSID}" -e S3_AWSSECRET="${S3_AWSSECRET}" -e S3_REGION="${S3_REGION}" -e S3_PREFIX="${ENV_TECH_ID}" \
  -e ENV_TECH_ID="${ENV_TECH_ID}" \
  -e HTTP_PROTOCOL="${HTTP_PROTOCOL}" -e DOMAIN="${DOMAIN}" \
  -e CLID="${CLID}" \
  -e CONNECT_URL="${CONNECT_URL}" \
  -e PACKAGES="${PACKAGES}" \
  -e ES_HOSTS="${ES_HOSTS}" \
  quay.io/nuxeoio/iocontainer:${CONTAINER_VERSION}
exit $?
