#!/bin/sh

/opt/data/tools/wait-container.sh $VBLOB_NAME

PORT=`docker port $VBLOB_NAME 9981 | awk -F : '{print $2}'`

/opt/data/tools/register-service.sh $S3_SERVICE $PORT

# Create the bucket on vBlob
/opt/data/tools/create-vblob-bucket $BUCKET_NAME

# Write config entries
/usr/bin/etcdctl set /config/s3/bucket $BUCKET_NAME
/usr/bin/etcdctl set /config/s3/awsid nuxeo
/usr/bin/etcdctl set /config/s3/awssecret nuxeo
/usr/bin/etcdctl set /config/s3/region us-east-1
