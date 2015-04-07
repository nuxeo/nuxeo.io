#!/bin/sh -

docker kill $KIBANA_NAME
/opt/data/tools/docker-clean.sh $KIBANA_NAME &> /dev/null

DOMAIN=kibana.`etcdctl get /services/manager/config/defaultDomainSuffix`
etcdctl rm --recursive /domains/${DOMAIN}
