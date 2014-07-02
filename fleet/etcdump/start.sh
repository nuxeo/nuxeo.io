#!/bin/sh -

NAME=etcdump
AWS_ACCESS_ID=`/usr/bin/etcdctl get /_arken.io/config/aws/id`
AWS_ACCESS_SECRET=`/usr/bin/etcdctl get /_arken.io/config/aws/secret`
S3_BUCKET=`/usr/bin/etcdctl get /_arken.io/config/s3/bucket`
REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

/opt/data/tools/docker-clean.sh ${NAME} &> /dev/null

docker pull $REGISTRY/nuxeo/etcdump
/usr/bin/docker run --rm -P -t --name ${NAME} \
  -e S3_BUCKET="${S3_BUCKET}" -e AWS_ACCESS_ID="${AWS_ACCESS_ID}" -e AWS_ACCESS_SECRET="${AWS_ACCESS_SECRET}" \
  $REGISTRY/nuxeo/etcdump
