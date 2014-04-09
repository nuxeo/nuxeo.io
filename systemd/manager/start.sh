#!/bin/sh

FLEETCTL=fleetctl
MANAGER_UNIT=manager
SCRIPTS=/opt/data/fleet/manager/manager.service

# Submit and start registry units if not already submitted
$FLEETCTL list-units --no-legend | grep $MANAGER_UNIT > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
  sleep 5
  $FLEETCTL start $SCRIPTS
else
  echo "Fleet units already loaded, you have to restart it manually."
fi
