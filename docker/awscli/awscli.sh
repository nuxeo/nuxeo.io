#!/bin/sh -

mkdir ~/.aws/

# Not sure to understand why echo -e doesn't work ...
echo "[default]" >> ~/.aws/config
echo "aws_secret_access_key = ${AWS_ACCESS_SECRET}" >> ~/.aws/config
echo "aws_access_key_id = ${AWS_ACCESS_ID}" >> ~/.aws/config
echo "output = text" >> ~/.aws/config

exec /usr/bin/aws $@
