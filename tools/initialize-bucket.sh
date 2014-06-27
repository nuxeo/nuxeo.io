#!/bin/sh

PREFIX=`etcdctl get /services/manager/config/defaultDnsSuffix`
USERNAME=${PREFIX}-${ENV_TECH_ID}

# Creating S3 user/bucket if needed
/opt/data/tools/awscli iam get-user --user-name $USERNAME &> /dev/null
if [ ! $? -eq 0 ]; then
  RAND=`openssl rand -hex 5`
  BUCKET=${PREFIX}-${ENV_TECH_ID}-${RAND}

  echo "Creating a new bucket $BUCKET for $USERNAME"

  # User/Bucket do not exists yet
  /opt/data/tools/awscli iam create-user --user-name $USERNAME --path /container/${PREFIX}/
  /opt/data/tools/awscli s3api create-bucket --bucket ${BUCKET}

  USER_POLICY="{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"${RAND}1\",\"Effect\":\"Allow\",\"Action\":[\"s3:*\"],\"Resource\":[\"arn:aws:s3:::${BUCKET}\"]},{\"Sid\":\"${RAND}2\",\"Effect\":\"Allow\",\"Action\":[\"s3:*\"],\"Resource\":[\"arn:aws:s3:::${BUCKET}/*\"]},{\"Sid\":\"${RAND}3\",\"Effect\":\"Allow\",\"Action\":[\"s3:ListAllMyBuckets\"],\"Resource\":[\"arn:aws:s3:::*\"]}]}"
  /opt/data/tools/awscli iam put-user-policy --user-name ${USERNAME} --policy-name ${USERNAME} --policy-document "${USER_POLICY}"

  KEYS_RES=`/opt/data/tools/awscli iam create-access-key --user-name ${USERNAME}`

  etcdctl set /services/${ENV_TECH_ID}/config/s3/bucket $BUCKET
  etcdctl set /services/${ENV_TECH_ID}/config/s3/username ${USERNAME}
  etcdctl set /services/${ENV_TECH_ID}/config/s3/awsid `echo $KEYS_RES | awk '{print $2}'`
  etcdctl set /services/${ENV_TECH_ID}/config/s3/awssecret `echo $KEYS_RES | awk '{print $4}'`
fi
