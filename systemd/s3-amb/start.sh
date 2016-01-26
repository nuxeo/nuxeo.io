#!/bin/sh
AMB_VERSION=latest

/opt/data/tools/docker-clean.sh ${S3_AMB_NAME} &> /dev/null

# Run Amazon S3 Ambassador container
/usr/bin/docker pull arken/service-amb:${AMB_VERSION}
/usr/bin/docker run --rm --name $S3_AMB_NAME -P quay.io/nuxeoio/service-amb:${AMB_VERSION} -servicePath /services/s3
echo "Container $S3_AMB_NAME is running."
