#!/bin/sh -

if [ -z "$var" ]; then
  echo "Service ID is empty, exiting $0"
  exit 1
fi

ETCDCTL=/usr/bin/etcdctl
if [ ! -x $ETCDCTL ]; then
  echo "Missing $ETCDCTL, exiting $0"
  exit 1
fi

AWSCLI=/opt/data/tools/awscli
if [ ! -x $AWSCLI ]; then
  echo "Missing $AWSCLI, exiting $0"
  exit 1
fi


S3_ACCESS_KEY=`$ETCDCTL get /services/${SERVICE_ID}/config/s3/awsid`
[ -z $S3_ACCESS_KEY ] && echo "No AWS access key, exiting $0" && exit 1
S3_BUCKET=`$ETCDCTL get /services/${SERVICE_ID}/config/s3/bucket`
[ -z $S3_ACCESS_KEY ] && echo "No AWS bucket configured for $SERVICE_ID, exiting $0" && exit 1
S3_REGION=`$ETCDCTL get /_arken.io/config/s3/region`
[ -z $S3_ACCESS_KEY ] && echo "No AWS access region configured, exiting $0" && exit 1
USERNAME=`$ETCDCTL get /services/${SERVICE_ID}/config/s3/username`
[ -z $S3_ACCESS_KEY ] && echo "No AWS username configured for $SERVICE_ID, exiting $0" && exit 1




if [ $S3_REGION != "us-east-1" ]; then
  $AWSCLI s3 rm --recursive --endpoint-url https://s3-$REGION.amazonaws.com/ s3://${S3_BUCKET}/${SERVICE_ID}
else
  $AWSCLI s3 rm --recursive s3://${S3_BUCKET}/${SERVICE_ID}
fi

$AWSCLI s3 rm --recursive s3://${S3_BUCKET}/${SERVICE_ID}
$AWSCLI iam delete-access-key --access-key-id ${S3_ACCESS_KEY} --user-name ${USERNAME}
$AWSCLI iam delete-user-policy --policy-name ${USERNAME} --user-name ${USERNAME}
$AWSCLI iam delete-user --user-name ${USERNAME}
