#!/bin/sh

FLEETCTL=fleetctl
POSTGRES_UNIT=postgres-service
SCRIPTS=/opt/data/fleet/postgres-service/postgres-service.service

# Submit and start registry units if not already submitted
$FLEETCTL list-units --no-legend | grep $POSTGRES_UNIT > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
  sleep 5
  $FLEETCTL start $SCRIPTS
else
  echo "Fleet units already loaded, you have to restart it manually."
fi
