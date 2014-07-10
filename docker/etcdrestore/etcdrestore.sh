#!/bin/sh -

/bin/write-awscli-conf.sh

if [ -z "$1" ]; then
  exit 1
fi

echo "Getting $1 etcd dump on $S3_BUCKET bucket."
/usr/bin/aws s3api get-object --bucket $S3_BUCKET --key $1 $1
if [ ! $? -eq 0 ]; then
  echo "Error while retrieving etcd dump from S3."
else
  echo "Successfuly retrieved etcd dump from S3."
fi

# restore etcd
echo "Restoring etcd"
etcdump --config /root/config.json --file `pwd`/$1 restore
if [ ! $? -eq 0 ]; then
  echo "Error while restoring etcd DB."
else
  echo "Successfuly restored etcd DB."
fi
