#!/bin/sh

/usr/bin/etcdctl set /services/$ENV_TECH_ID/1/status/current starting
/opt/data/tools/initialize-bucket.sh
