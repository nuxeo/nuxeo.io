#!/bin/sh -

DOMAIN=`etcdctl get /services/${SERVICE_ID}/1/domain`

etcdctl rm --recursive /services/${SERVICE_ID}
etcdctl rm --recursive /domains/${DOMAIN}
