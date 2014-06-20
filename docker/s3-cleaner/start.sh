#/bin/sh -

# Settings
sed -i 's/awsid/$S3_AWSID/g' /usr/bin/.s3curl
sed -i 's/awssecret/$S3_AWSSECRET/g' /usr/bin/.s3curl

# Get and Delete S3 bucket prefix content
/usr/bin/s3curl.pl --id nuxeo -- https://$S3_BUCKET.s3.amazonaws.com | grep -E -o '$S3_BUCKET_PREFIX[^<]+' | while read line; do
    /usr/bin/s3curl.pl --id nuxeo --delete -- http://$S3_BUCKET.s3.amazonaws.com/"$line"
done