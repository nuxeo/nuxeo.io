#!/bin/sh -

S3_ACCESS_KEY=`etcdctl get /services/${SERVICE_ID}/config/s3/awsid`
S3_BUCKET=`etcdctl get /services/${SERVICE_ID}/config/s3/bucket`
S3_REGION=`us-east-1`
USERNAME=`etcdctl get /services/${SERVICE_ID}/config/s3/username`

/opt/data/tools/awscli s3 rm --region ${S3_REGION} --recursive s3://${S3_BUCKET}/${SERVICE_ID}
/opt/data/tools/awscli iam delete-access-key --access-key-id ${S3_ACCESS_KEY} --user-name ${USERNAME}
/opt/data/tools/awscli iam delete-user-policy --policy-name ${USERNAME} --user-name ${USERNAME}
/opt/data/tools/awscli iam delete-user --user-name ${USERNAME}
