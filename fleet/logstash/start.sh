#!/bin/bash -

ESL_PORT=9301
# Find a local ESL node, otherwise use any up node
curl -s -m 2 -f ${COREOS_PRIVATE_IPV4}:${ESL_PORT} &> /dev/null
if [ "$?" = "0" ]; then
  ESL_HOST=${COREOS_PRIVATE_IPV4}
else
  ESL_HOST=`etcdctl ls --recursive /services/elasticsearchlogs \
    | grep transport \
    | shuf -n 1 \
    | xargs etcdctl get \
    | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1/'`
fi

/usr/bin/docker pull quay.io/nuxeoio/logstash:${LOGSTASH_VERSION}
/usr/bin/docker run --rm --name $LOGSTASH_NAME \
  -p 4560:4560 \
  -e ESL_HOST="${ESL_HOST}" \
  -e ESL_PORT="${ESL_PORT}" \
  -e ESL_CLUSTER="nuxeologs" \
  quay.io/nuxeoio/logstash:${LOGSTASH_VERSION}
