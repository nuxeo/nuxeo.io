#!/bin/bash -

# stop registered images build
fleetctl stop build-cleaners
fleetctl stop build-io-base
fleetctl stop build-io-container
fleetctl stop postgres-service
fleetctl stop vblob-service

sleep 5

# start and push postgres and vblob only on Vagrant
VIRT=`systemd-detect-virt`
if [ $VIRT = "oracle" ] ; then
  fleetctl start /opt/data/fleet/postgres-service/postgres-service.service
  /opt/data/tools/wait-fleet-unit.sh postgres-service.service

  fleetctl start /opt/data/fleet/vblob-service/vblob-service.service
  /opt/data/tools/wait-fleet-unit.sh vblob-service.service
fi

# build and push standard images
fleetctl start /opt/data/fleet/build-cleaners/build-cleaners.service

fleetctl start /opt/data/fleet/build-io-base/build-io-base.service
/opt/data/tools/wait-fleet-unit.sh build-io-base.service

fleetctl start /opt/data/fleet/build-io-container/build-io-container.service

# etcdump needs awscli as base image, so waiting it's completion
/opt/data/tools/wait-fleet-unit.sh build-cleaners.service

fleetctl start /opt/data/fleet/build-etcdump/build-etcdump.service
