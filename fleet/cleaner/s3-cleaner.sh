#!/bin/sh -

S3_ACCESS_KEY=`etcdctl get /services/${SERVICE_ID}/config/s3/awsid`
S3_BUCKET=`etcdctl get /services/${SERVICE_ID}/config/s3/bucket`
USERNAME=`etcdctl get /services/${SERVICE_ID}/config/s3/username`

/opt/data/tools/awscli s3api delete-bucket --bucket ${S3_BUCKET}
/opt/data/tools/awscli iam delete-access-key --access-key-id ${S3_ACCESS_KEY} --user-name ${USERNAME}
/opt/data/tools/awscli iam delete-user-policy --policy-name ${USERNAME} --user-name ${USERNAME}
/opt/data/tools/awscli iam delete-user --user-name ${USERNAME}
