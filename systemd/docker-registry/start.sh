#!/bin/sh

FLEETCTL=fleetctl
REGISTRY_UNIT=docker-registry
SCRIPTS=/opt/data/fleet/docker-registry/docker-registry.service

# Submit and start registry units if not already submitted
$FLEETCTL list-units --no-legend | grep $REGISTRY_UNIT > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
  sleep 5
  $FLEETCTL start $SCRIPTS
else
  echo "Fleet units already loaded, you have to restart it manually."
fi
