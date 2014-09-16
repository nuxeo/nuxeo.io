#!/bin/sh

/usr/bin/etcdctl set --ttl $((7 * 60)) /services/$ENV_TECH_ID/1/status/current starting
/usr/bin/docker pull quay.io/nuxeoio/iocontainer

exec /opt/data/tools/initialize-bucket.sh
