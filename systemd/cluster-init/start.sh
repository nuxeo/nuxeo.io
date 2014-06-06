#!/bin/sh

# fleet units
INITIALIZED=`/usr/bin/etcdctl get /arken.io/initialized`
if [ $? -eq 0 ]; then
  exit 0
fi
/usr/bin/etcdctl set /arken.io/initialized true

fleetctl start /opt/data/fleet/passivator/passivator.service
/opt/data/tools/wait-fleet-unit.sh passivator.service

fleetctl start /opt/data/fleet/docker-registry/docker-registry.service
/opt/data/tools/wait-fleet-unit.sh docker-registry.service

# start postgres and vblob only on Vagrant
VIRT=`systemd-detect-virt`
if [ $VIRT = "oracle" ] ; then
  fleetctl start /opt/data/fleet/postgres-service/postgres-service.service
  /opt/data/tools/wait-fleet-unit.sh postgres-service.service

  fleetctl start /opt/data/fleet/vblob-service/vblob-service.service
  /opt/data/tools/wait-fleet-unit.sh vblob-service.service
fi

fleetctl start /opt/data/fleet/build-io-base/build-io-base.service
/opt/data/tools/wait-fleet-unit.sh build-io-base.service

fleetctl start /opt/data/fleet/build-io-container/build-io-container.service
/opt/data/tools/wait-fleet-unit.sh build-io-container.service

fleetctl start /opt/data/fleet/manager/manager.service
/opt/data/tools/wait-fleet-unit.sh manager.service