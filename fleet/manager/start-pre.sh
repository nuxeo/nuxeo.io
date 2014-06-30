#!/bin/sh

# copy the coreos fleetctl binary for the manager
cp /usr/bin/fleetctl /opt/data/docker/manager/fleetctl
/usr/bin/docker build -t nuxeo/manager /opt/data/docker/manager/

ENV_TECH_ID=manager /opt/data/tools/initialize-bucket.sh
