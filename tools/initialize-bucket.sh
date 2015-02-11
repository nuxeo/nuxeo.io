#!/bin/sh

ETCDCTL=/usr/bin/etcdctl
if [ ! -x $ETCDCTL ]; then
  echo "ERROR: Missing $ETCDCTL, exiting $0"
  exit 1
fi

AWSCLI=/opt/data/tools/awscli
if [ ! -x $AWSCLI ]; then
  echo "ERROR: Missing $AWSCLI, exiting $0"
  exit 1
fi


[ -z $ENV_TECH_ID ] && echo "ERROR: No environment tech id given, exiting $0" && exit 1
PREFIX=`$ETCDCTL get /_arken.io/key`
[ -z $PREFIX ] && echo "ERROR: No arken prefix configured, exiting $0" && exit 1
USERNAME=${PREFIX}-${ENV_TECH_ID}
BUCKET=`$ETCDCTL get /_arken.io/config/s3/bucket`
[ -z $BUCKET ] && echo "ERROR: No bucket configured for this cluster, exiting $0" && exit 1
REGION=`$ETCDCTL get /_arken.io/config/s3/region`
[ -z $REGION ] && echo "ERROR: No region configured for this cluster, exiting $0" && exit 1
RAND=`openssl rand -hex 5`
DIRECTORY=${ENV_TECH_ID}


# Creating S3 user if needed
$AWSCLI iam get-user --user-name $USERNAME &> /dev/null
if [ ! $? -eq 0 ]; then
  echo "Creating user $USERNAME for $ENV_TECH_ID"
  $AWSCLI iam create-user --user-name $USERNAME --path /container/${PREFIX}/
fi
$ETCDCTL set /services/${ENV_TECH_ID}/config/s3/bucket ${BUCKET}
$ETCDCTL set /services/${ENV_TECH_ID}/config/s3/username ${USERNAME}

COUNT=`$AWSCLI iam list-user-policies --user-name $USERNAME | wc -l`
if [ $COUNT -eq 0 ]; then
  # UserPolicy to allow user only on his own directory
  USER_POLICY="{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"${RAND}1\",\"Effect\":\"Allow\",\"Action\":[\"s3:*\"],\"Resource\":[\"arn:aws:s3:::${BUCKET}\"]},{\"Sid\":\"${RAND}2\",\"Effect\":\"Allow\",\"Action\":[\"s3:*\"],\"Resource\":[\"arn:aws:s3:::${BUCKET}/${DIRECTORY}/*\"]},{\"Sid\":\"${RAND}3\",\"Effect\":\"Allow\",\"Action\":[\"s3:ListAllMyBuckets\"],\"Resource\":[\"arn:aws:s3:::${BUCKET}\"]}]}"
  $AWSCLI iam put-user-policy --user-name ${USERNAME} --policy-name ${USERNAME} --policy-document "${USER_POLICY}"
fi

`$ETCDCTL get /services/${ENV_TECH_ID}/config/s3/awsid &> /dev/null`
if [ ! $? -eq 0 ]; then
  KEYS_RES=`$AWSCLI iam create-access-key --user-name ${USERNAME}`

  $ETCDCTL set /services/${ENV_TECH_ID}/config/s3/awsid `echo ${KEYS_RES} | awk '{print $2}'`
  $ETCDCTL set /services/${ENV_TECH_ID}/config/s3/awssecret `echo ${KEYS_RES} | awk '{print $4}'`
fi

# Check bucket/awscli up and running
if [ $REGION != "us-east-1" ]; then
  exec $AWSCLI s3api head-bucket --endpoint-url https://s3-$REGION.amazonaws.com/ --bucket ${BUCKET}
else
  exec $AWSCLI s3api head-bucket --bucket ${BUCKET}
fi
