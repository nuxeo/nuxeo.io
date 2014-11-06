#!/bin/sh

/usr/bin/etcdctl set --ttl $((7 * 60)) /services/$ENV_TECH_ID/1/status/current starting
/usr/bin/etcdctl set /services/$ENV_TECH_ID/1/lastAccess "`/usr/bin/date +"%Y-%m-%d %H:%M:%S"`"

exec /opt/data/tools/initialize-bucket.sh
