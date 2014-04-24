#!/bin/sh

FLEETCTL=fleetctl
VBLOB_UNIT=vblob-service
SCRIPTS=/opt/data/fleet/vblob-service/vblob-service.service

# Submit and start registry units if not already submitted
$FLEETCTL list-units --no-legend | grep $VBLOB_UNIT > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
  sleep 5
  $FLEETCTL start $SCRIPTS
else
  echo "Fleet units already loaded, you have to restart it manually."
fi
