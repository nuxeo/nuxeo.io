#!/bin/sh

# Should be in a stopPre script but it doesn't exist
/usr/bin/etcdctl set /services/$ENV_TECH_ID/1/status/current stopping

docker stop $ENV_TECH_ID
