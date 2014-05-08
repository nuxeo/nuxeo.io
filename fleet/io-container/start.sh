#!/bin/sh

POSTGRES_AMB=postgres-amb
S3_AMB=s3-amb
PG_PWD=`openssl rand -hex 15`
REGISTRY=`/usr/bin/etcdctl get /docker/registry`
S3_BUCKET=`/usr/bin/etcdctl get /config/s3/bucket`
S3_BUCKET_PREFIX=`/usr/bin/etcdctl get /config/s3/bucket.prefix`
S3_AWSID=`/usr/bin/etcdctl get /config/s3/awsid`
S3_AWSSECRET=`/usr/bin/etcdctl get /config/s3/awssecret`
S3_REGION=`/usr/bin/etcdctl get /config/s3/region`
DOMAIN=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/1/domain`
CLID=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/1/config/instance.clid`
CONNECT_URL=`/usr/bin/etcdctl get /config/connect/url`
if [ ! $? -eq 0 ]; then
  CONNECT_URL=""
fi
REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

PACKAGES=`/usr/bin/etcdctl get /services/${ENV_TECH_ID}/1/config/packages`
if [ ! $? -eq 0 ]; then
  PACKAGES="nuxeo-dm nuxeo-dam nuxeo-drive nuxeo-template-rendering nuxeo-csv nuxeo-web-mobile-dm"
fi

/usr/bin/docker run --rm -P -t --name ${ENV_TECH_ID} \
  --link ${POSTGRES_AMB}:db \
  --link ${S3_AMB}:s3 \
  -e PG_DB_NAME="${ENV_TECH_ID}" -e PG_ROLE_NAME="${ENV_TECH_ID}" -e PG_PWD="${PG_PWD}" \
  -e PGPASSWORD="nuxeoiopostgres" \
  -e S3_BUCKET="${S3_BUCKET}" -e S3_AWSID="${S3_AWSID}" -e S3_AWSSECRET="${S3_AWSSECRET}" -e S3_REGION="${S3_REGION}" -e S3_BUCKET_PREFIX="${ENV_TECH_ID}" \
  -e ENV_TECH_ID="${ENV_TECH_ID}" \
  -e DOMAIN="${DOMAIN}" \
  -e CLID="${CLID}" \
  -e CONNECT_URL="${CONNECT_URL}" \
  -e PACKAGES="${PACKAGES}" \
  ${REGISTRY}/nuxeo/iocontainer
