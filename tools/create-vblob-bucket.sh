#!/bin/sh -

if [ $# -lt 1 ]; then
  echo "Usage: $0 BUCKET_NAME"
  exit 1
fi

IP=`/opt/data/tools/resolve-ip.sh`
PORT=`docker port s3-amb 1337 | awk -F : '{print $2}'`
curl http://$IP:$PORT/$1 -X PUT -v
