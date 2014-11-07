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
for i in 1 2 3; do
  fleetctl start /opt/data/fleet/elasticsearch/elasticsearch-${i}.service
  sleep 15
  fleetctl start /opt/data/fleet/elasticsearch/elastic-discovery-${i}.service
  sleep 10
done;

/opt/data/tools/wait-fleet-unit.sh manager.service
