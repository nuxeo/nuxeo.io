#!/bin/sh -

if [ $# -lt 1 ]; then
  echo "Usage: $0 BUCKET_NAME"
  exit 1
fi

curl http://localhost:9981/$1 -X PUT -v
