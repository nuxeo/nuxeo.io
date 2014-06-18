#/bin/sh -

# Settings
sed -i 's/awsid/$S3_AWSID/g' /usr/bin/.s3curl
sed -i 's/awssecret/$S3_AWSSECRET/g' /usr/bin/.s3curl

# Delete S3 bucket
/s3curl.pl --id=nuxeo --delete -- http://$S3_BUCKET.s3.amazonaws.com?prefix=$S3_BUCKET_PREFIX
