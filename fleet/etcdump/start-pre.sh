#!/bin/sh

AWS_ACCESS_ID=`/usr/bin/etcdctl get /_arken.io/config/aws/id`
AWS_ACCESS_SECRET=`/usr/bin/etcdctl get /_arken.io/config/aws/secret`


BUCKET=`/usr/bin/etcdctl get /_arken.io/config/s3/bucket`
if [ ! $? -eq 0 ]; then
  PREFIX=`etcdctl get /_arken.io/key`
  RAND=`openssl rand -hex 5`
  BUCKET=${PREFIX}-etcdump-${RAND}
fi

/opt/data/tools/awscli s3api list-objects --bucket ${BUCKET} --max-items 1
if [ ! $? -eq 0 ]; then
  echo "Creating a new bucket $BUCKET"

  /opt/data/tools/awscli s3api create-bucket --bucket ${BUCKET}

  etcdctl set /_arken.io/config/s3/bucket $BUCKET
fi
