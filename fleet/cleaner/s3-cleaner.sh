#!/bin/sh -

S3_BUCKET=`etcdctl get /config/s3/bucket`
S3_REGION=`etcdctl get /config/s3/region`

/opt/data/tools/awscli s3 rm --region=${S3_REGION} --recursive s3://${S3_BUCKET}/$1/
