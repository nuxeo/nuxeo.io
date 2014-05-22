#!/bin/sh

# Run Amazon S3 Ambassador container
/usr/bin/docker run --rm --name $S3_AMB_NAME -P nuxeo/service-amb s3
