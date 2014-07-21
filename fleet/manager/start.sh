#!/bin/sh

PG_PWD=`openssl rand -hex 15`
REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`
DB_PORT_1337_TCP_ADDR=`etcdctl get /services/postgres-service/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1/'`
DB_PORT_1337_TCP_PORT=`etcdctl get /services/postgres-service/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\2/'`
SSO_URL=`/usr/bin/etcdctl get /_arken.io/config/sso/location`
S3_BUCKET=`/usr/bin/etcdctl get /services/manager/config/s3/bucket`
S3_AWSID=`/usr/bin/etcdctl get /services/manager/config/s3/awsid`
S3_AWSSECRET=`/usr/bin/etcdctl get /services/manager/config/s3/awssecret`
S3_REGION=`/usr/bin/etcdctl get /_arken.io/config/s3/region`
DOMAIN=`/usr/bin/etcdctl get /services/manager/config/domain`
DEFAULT_DOMAIN_SUFFIX=`/usr/bin/etcdctl get /services/manager/config/defaultDomainSuffix`
if [ ! $? -eq 0 ]; then
  DEFAULT_DOMAIN_SUFFIX=""
fi

CONNECT_URL=`/usr/bin/etcdctl get /config/connect/url`
if [ ! $? -eq 0 ]; then
  CONNECT_URL=""
fi

OAUTH=`/usr/bin/etcdctl get /config/manager/oauth`
if [ $? -eq 0 ]; then
  OAUTH_CONSUMER_KEY=`echo $OAUTH | sed -e 's/{"key":"\([^"]*\)","secret":"\([^"]*\)"}/\1/'`
  OAUTH_CONSUMER_SECRET=`echo $OAUTH | sed -e 's/{"key":"\([^"]*\)","secret":"\([^"]*\)"}/\2/'`
else
  OAUTH_CONSUMER_KEY=""
  OAUTH_CONSUMER_SECRET=""
fi

HTTP_PROTOCOL=`/usr/bin/etcdctl get /_arken.io/config/http/protocol`
if [ ! $? -eq 0 ]; then
  HTTP_PROTOCOL="http"
fi

/opt/data/tools/docker-clean.sh ${MANAGER_NAME} &> /dev/null

/usr/bin/docker run --rm -P -t --name ${MANAGER_NAME} \
  -e DB_PORT_1337_TCP_ADDR="${DB_PORT_1337_TCP_ADDR}" -e DB_PORT_1337_TCP_PORT="${DB_PORT_1337_TCP_PORT}" \
  -e PG_DB_NAME="${MANAGER_NAME}" -e PG_ROLE_NAME="${MANAGER_NAME}" -e PG_PWD="${PG_PWD}" \
  -e PGPASSWORD="nuxeoiopostgres" \
  -e S3_BUCKET="${S3_BUCKET}" -e S3_AWSID="${S3_AWSID}" -e S3_AWSSECRET="${S3_AWSSECRET}" -e S3_REGION="${S3_REGION}" \
  -e HTTP_PROTOCOL="${HTTP_PROTOCOL}" -e DOMAIN="${DOMAIN}" \
  -e DEFAULT_DOMAIN_SUFFIX="${DEFAULT_DOMAIN_SUFFIX}" \
  -e CONNECT_URL="${CONNECT_URL}" -e SSO_URL="${SSO_URL}" \
  -e OAUTH_CONSUMER_KEY="${OAUTH_CONSUMER_KEY}" -e OAUTH_CONSUMER_SECRET="${OAUTH_CONSUMER_SECRET}" \
  nuxeo/manager
