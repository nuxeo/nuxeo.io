#!/bin/sh

# fleet units
INITIALIZED=`/usr/bin/etcdctl get /_arken.io/initialized`
if [ $? -eq 0 ]; then
  exit 0
fi
/usr/bin/etcdctl set /_arken.io/initialized true

fleetctl start /opt/data/fleet/passivator/passivator.service
fleetctl start /opt/data/fleet/manager/manager.service
fleetctl start /opt/data/fleet/etcdump/etcdump.service

# Start an elasticsearch cluster
fleetctl submit /opt/data/fleet/elasticsearch-discovery@{1..3}.service
fleetctl start /opt/data/fleet/elasticsearch@1.service
sleep 10
fleetctl start /opt/data/fleet/elasticsearch@{2..3}.service


/opt/data/tools/wait-fleet-unit.sh manager.service
