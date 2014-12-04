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
/opt/data/tools/restart-es.sh

/opt/data/tools/wait-fleet-unit.sh manager.service
