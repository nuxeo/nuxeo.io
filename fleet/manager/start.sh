#!/bin/sh

POSTGRES_AMB=postgres-amb
S3_AMB=s3-amb
while ! docker ps | grep -q $POSTGRES_AMB
do
    sleep 2
done

PG_PWD=`openssl rand -hex 15`
REGISTRY=`/usr/bin/etcdctl get /docker/registry`
S3_BUCKET=`/usr/bin/etcdctl get /config/s3/bucket`
S3_AWSID=`/usr/bin/etcdctl get /config/s3/awsid`
S3_AWSSECRET=`/usr/bin/etcdctl get /config/s3/awssecret`
S3_REGION=`/usr/bin/etcdctl get /config/s3/region`
DEFAULT_DNS_SUFFIX=`/usr/bin/etcdctl get /config/manager/defaultDnsSuffix`

/usr/bin/docker run --rm -P -t --name ${MANAGER_NAME} \
  --link ${POSTGRES_AMB}:db \
  --link ${S3_AMB}:s3 \
  -e PG_DB_NAME=${MANAGER_NAME} -e PG_ROLE_NAME=${MANAGER_NAME} -e PG_PWD=${PG_PWD} \
  -e PGPASSWORD=nuxeoiopostgres \
  -e S3_BUCKET=${S3_BUCKET} -e S3_AWSID=${S3_AWSID} -e S3_AWSSECRET=${S3_AWSSECRET} -e S3_REGION=${S3_REGION} \
  -e DOMAIN=${MANAGER_DOMAIN} \
  -e DEFAULT_DNS_SUFFIX=${DEFAULT_DNS_SUFFIX} \
  ${REGISTRY}/nuxeo/manager
