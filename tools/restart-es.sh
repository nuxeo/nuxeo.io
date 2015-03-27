#!/bin/sh -

ES_NAME=${1:-elasticsearch}
DISCOVERY_NAME=${2:-elasticdiscovery}
DIR_NAME=${3:-${ES_NAME}}

echo "Destroying old units"
for i in 1 2 3; do
  fleetctl destroy ${ES_NAME}@${i}.service
  fleetctl destroy ${DISCOVERY_NAME}@${i}.service
done

fleetctl destroy /opt/data/fleet/${DIR_NAME}/${ES_NAME}@.service
fleetctl submit /opt/data/fleet/${DIR_NAME}/${ES_NAME}@.service

fleetctl destroy /opt/data/fleet/${DIR_NAME}/${DISCOVERY_NAME}@.service
fleetctl submit /opt/data/fleet/${DIR_NAME}/${DISCOVERY_NAME}@.service

echo "Starting new units"
for i in 1 2 3; do
  fleetctl start /opt/data/fleet/${DIR_NAME}/${ES_NAME}@${i}.service
  sleep 15
  fleetctl start /opt/data/fleet/${DIR_NAME}/${DISCOVERY_NAME}@${i}.service
  sleep 10
done;
