#!/bin/sh

# Run Amazon S3 Ambassador container
/usr/bin/docker pull arken/service-amb
/usr/bin/docker run --rm --name $S3_AMB_NAME -P arken/service-amb -servicePath /services/s3
echo "Container $S3_AMB_NAME is running."
