#!/bin/sh -

/bin/write-awscli-conf.sh

NOW=`date +"%m_%d_%Y-%H_%M"`

# dump etcd
echo "Dumping etcd"
etcdump --config /root/config.json --file etcd_dump_$NOW.json dump
if [ ! $? -eq 0 ]; then
  echo "Error while dumping etcd."
else
  echo "Successfuly dumped etcd DB."
fi

# push on s3
/usr/bin/aws s3api put-object --bucket $S3_BUCKET --key etcd_dump_$NOW.json --body etcd_dump_$NOW.json
if [ ! $? -eq 0 ]; then
  echo "Error while pushing etcd dump on S3."
else
  echo "Successfuly pushed etcd dump on S3."
fi
