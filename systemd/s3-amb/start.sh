#!/bin/sh

# Run Amazon S3 Ambassador container
/usr/bin/docker run --rm --name s3-amb -P nuxeo/service-amb s3
