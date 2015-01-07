#!/bin/bash

/opt/data/tools/docker-clean.sh arken-watch &> /dev/null

exec /usr/bin/docker run --rm --name arken-watch -h `hostname` -e DD_API_KEY=`etcdctl get /config/datadog/key` quay.io/nuxeoio/arkenctl watch
