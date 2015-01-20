#!/bin/sh -

if [ -z "${SERVICE_ID}" ]; then
  exit 1
fi
etcdctl rm --recursive /services/${SERVICE_ID}

DOMAIN=`etcdctl get /services/${SERVICE_ID}/1/domain`
if [ $? -eq 0 ]; then
  etcdctl rm --recursive /domains/${DOMAIN}
fi
