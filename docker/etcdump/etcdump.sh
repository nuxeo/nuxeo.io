#!/bin/sh -

/bin/write-awscli-conf.sh

NOW=`date +"%m_%d_%Y-%H_%M"`

# dump etcd
etcdump --config /root/config.json --file etcd_dump_$NOW.json dump

# push on s3
/usr/bin/aws s3api put-object --bucket $S3_BUCKET --key etcd_dump_$NOW.json --body etcd_dump_$NOW.json
