#!/bin/sh

# Write service entries
/usr/bin/etcdctl set /services/s3/1/location \{\"host\":\"s3.amazonaws.com\",\"port\":80\}

# Run Amazon S3 Ambassador container
/usr/bin/docker run --rm --name s3-amb -P nuxeo/service-amb s3
