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

fleetctl submit /opt/data/fleet/elasticsearch/elasticsearch-discovery-1.service
fleetctl start /opt/data/fleet/elasticsearch/elasticsearch-1.service
sleep 10
for i in 2 3; do
  fleetctl submit /opt/data/fleet/elasticsearch/elasticsearch-discovery-${i}.service
  sleep 1
  fleetctl start /opt/data/fleet/elasticsearch-${i}.service
done;

/opt/data/tools/wait-fleet-unit.sh manager.service
