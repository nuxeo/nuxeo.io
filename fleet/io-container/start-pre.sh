#!/bin/sh

/usr/bin/etcdctl set --ttl $((7 * 60)) /services/$ENV_TECH_ID/1/status/current starting
exec /opt/data/tools/initialize-bucket.sh
