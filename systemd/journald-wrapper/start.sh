#!/bin/bash

/opt/data/tools/docker-clean.sh journald-wrapper &> /dev/null

AWS_ACCESS_ID=`/usr/bin/etcdctl get /_arken.io/config/aws/id`
AWS_ACCESS_SECRET=`/usr/bin/etcdctl get /_arken.io/config/aws/secret`
AWS_REGION=`/usr/bin/etcdctl get /_arken.io/config/s3/region`
PREFIX=`/usr/bin/etcdctl get /_arken.io/key`

exec docker run --name journald-wrapper -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_ID -e AWS_SECRET_ACCESS_KEY=$AWS_ACCESS_SECRET -e AWS_REGION=$AWS_REGION -e PREFIX=$PREFIX --rm quay.io/nuxeoio/journald-wrapper
