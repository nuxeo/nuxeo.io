#!/bin/sh

POSTGRES_AMB=postgres-amb
S3_AMB=s3-amb

/opt/data/tools/wait-container.sh $POSTGRES_AMB
/opt/data/tools/wait-container.sh $S3_AMB

PG_PWD=`openssl rand -hex 15`
REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`
SSO_URL=`/usr/bin/etcdctl get /_arken.io/config/sso/location`
S3_BUCKET=`/usr/bin/etcdctl get /services/manager/config/s3/bucket`
S3_AWSID=`/usr/bin/etcdctl get /services/manager/config/s3/awsid`
S3_AWSSECRET=`/usr/bin/etcdctl get /services/manager/config/s3/awssecret`
S3_REGION=`/usr/bin/etcdctl get /_arken.io/config/s3/region`
DOMAIN=`/usr/bin/etcdctl get /services/manager/config/domain`
DEFAULT_DNS_SUFFIX=`/usr/bin/etcdctl get /services/manager/config/defaultDnsSuffix`
if [ ! $? -eq 0 ]; then
  DEFAULT_DNS_SUFFIX=""
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

/opt/data/tools/docker-clean.sh ${MANAGER_NAME} &> /dev/null

/usr/bin/docker run --rm -P -t --name ${MANAGER_NAME} \
  --link ${POSTGRES_AMB}:db \
  --link ${S3_AMB}:s3 \
  -e PG_DB_NAME="${MANAGER_NAME}" -e PG_ROLE_NAME="${MANAGER_NAME}" -e PG_PWD="${PG_PWD}" \
  -e PGPASSWORD="nuxeoiopostgres" \
  -e S3_BUCKET="${S3_BUCKET}" -e S3_AWSID="${S3_AWSID}" -e S3_AWSSECRET="${S3_AWSSECRET}" -e S3_REGION="${S3_REGION}" \
  -e DOMAIN="${DOMAIN}" \
  -e DEFAULT_DNS_SUFFIX="${DEFAULT_DNS_SUFFIX}" \
  -e CONNECT_URL="${CONNECT_URL}" -e SSO_URL="${SSO_URL}" \
  -e OAUTH_CONSUMER_KEY="${OAUTH_CONSUMER_KEY}" -e OAUTH_CONSUMER_SECRET="${OAUTH_CONSUMER_SECRET}" \
  nuxeo/manager
