#!/bin/sh

POSTGRES_AMB=postgres-amb
S3_AMB=s3-amb
PG_PWD=`openssl rand -hex 15`
S3_BUCKET=`/usr/bin/etcdctl get /config/s3/bucket`
S3_AWSID=`/usr/bin/etcdctl get /config/s3/awsid`
S3_AWSSECRET=`/usr/bin/etcdctl get /config/s3/awssecret`
S3_REGION=`/usr/bin/etcdctl get /config/s3/region`

/usr/bin/docker run --rm -P -t --name ${ENV_TECH_ID} \
  --link ${POSTGRES_AMB}:db \
  --link ${S3_AMB}:s3 \
  -e PG_DB_NAME=${ENV_TECH_ID} -e PG_ROLE_NAME=${ENV_TECH_ID} -e PG_PWD=${PG_PWD} \
  -e PGPASSWORD=nuxeoiopostgres \
  -e S3_BUCKET=${S3_BUCKET} -e S3_AWSID=${S3_AWSID} -e S3_AWSSECRET=${S3_AWSSECRET} -e S3_REGION=${S3_REGION} \
  -e ENV_TECH_ID=${ENV_TECH_ID} \
  ${DOCKER_REGISTRY}/nuxeo/iocontainer
