#!/bin/sh

FLEETCTL=fleetctl
UNIT_NAME=build-io-base
SCRIPTS=/opt/data/fleet/build-io-base/build-io-base.service

# Submit and start registry units if not already submitted
$FLEETCTL list-units --no-legend | grep $UNIT_NAME > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
  sleep 5
  $FLEETCTL start $SCRIPTS
else
  echo "Fleet units already loaded, you have to restart it manually."
fi
