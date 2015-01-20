#!/bin/sh -

HOST=`etcdctl ls --recursive /services/elasticsearch \
  | grep transport \
  | head -n 1 \
  | xargs etcdctl get \
  | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:9200/'`

# Delete ElasticSearch index
if [ $? -eq 0 ] && [ -n "${HOST}" ]; then
  curl -XDELETE "http://${HOST}/${SERVICE_ID}"
else
  echo "Unable to correctly clean ES"
  exit 1
fi
