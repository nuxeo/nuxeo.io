#!/bin/bash

/opt/data/tools/docker-clean.sh dd-agent &> /dev/null

etcdctl get /config/datadog/key 2>&1 > /dev/null
if [ $? -eq 0 ]; then
    /usr/bin/docker run --rm --privileged --name dd-agent -h `hostname` -v /var/run/docker.sock:/var/run/docker.sock -v /proc/mounts:/host/proc/mounts:ro -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro -e API_KEY=`etcdctl get /config/datadog/key`  datadog/docker-dd-agent
else
    echo "API key not configured (/config/datadog/key), not starting dd-agent"
    exit 1
fi
