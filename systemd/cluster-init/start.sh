#!/bin/sh

# fleet units
INITIALIZED=`/usr/bin/etcdctl get /_arken.io/initialized`
if [ $? -eq 0 ]; then
  exit 0
fi
/usr/bin/etcdctl set /_arken.io/initialized true

fleetctl start /opt/data/fleet/passivator/passivator.service

fleetctl start /opt/data/fleet/docker-registry/docker-registry.service
/opt/data/tools/wait-fleet-unit.sh docker-registry.service

# start fill-registry script
/opt/data/tools/fill-registry.sh

fleetctl start /opt/data/fleet/manager/manager.service

/opt/data/tools/wait-fleet-unit.sh build-etcdump.service
fleetctl start /opt/data/fleet/etcdump/etcdump.service

/opt/data/tools/wait-fleet-unit.sh manager.service
