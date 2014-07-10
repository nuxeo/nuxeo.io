#!/bin/sh -

/bin/write-awscli-conf.sh

NOW=`date +"%Y_%m_%d-%H_%M"`

# dump etcd
echo "Dumping arken etcd"
etcdump --config /root/config-arken.json --file etcd_dump_arken_$NOW.json dump
if [ ! $? -eq 0 ]; then
  echo "Error while dumping arken etcd."
else
  echo "Successfuly dumped arken etcd DB."
fi
echo "Dumping fleet etcd"
etcdump --config /root/config-fleet.json --file etcd_dump_fleet_$NOW.json dump
if [ ! $? -eq 0 ]; then
  echo "Error while dumping fleet etcd."
else
  echo "Successfuly dumped fleet etcd DB."
fi

# push on s3
/usr/bin/aws s3api put-object --bucket $S3_BUCKET --key etcd_dump_arken_$NOW.json --body etcd_dump_arken_$NOW.json
if [ ! $? -eq 0 ]; then
  echo "Error while pushing arken etcd dump on S3."
else
  echo "Successfuly pushed etcd arken dump on S3."
fi

/usr/bin/aws s3api put-object --bucket $S3_BUCKET --key etcd_dump_fleet_$NOW.json --body etcd_dump_fleet_$NOW.json
if [ ! $? -eq 0 ]; then
  echo "Error while pushing etcd fleet dump on S3."
else
  echo "Successfuly pushed etcd fleet dump on S3."
fi
