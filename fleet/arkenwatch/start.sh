#!/bin/bash

/opt/data/tools/docker-clean.sh arken-watch &> /dev/null

etcdctl get /config/datadog/key 2>&1 > /dev/null
if [ $? -eq 0 ]; then
    /usr/bin/docker run --rm --name arken-watch -h `hostname` -e DD_API_KEY=`etcdctl get /config/datadog/key` quay.io/nuxeoio/arkenctl watch
else
    echo "API key not configured (/config/datadog/key), not starting dd-agent"
    exit 1
fi
