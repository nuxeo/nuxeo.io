#!/bin/sh -

ES_NAME=${1:-elasticsearch}
DISCOVERY_NAME=${2:-elasticdiscovery}

echo "Destroying old units"
for i in 1 2 3; do
  fleetctl destroy elasticsearch@${i}.service
  fleetctl destroy elasticdiscovery@${i}.service
done

fleetctl destroy /opt/data/fleet/elasticsearch/${ES_NAME}@.service
fleetctl submit /opt/data/fleet/elasticsearch/${ES_NAME}@.service

fleetctl destroy /opt/data/fleet/elasticsearch/${DISCOVERY_NAME}@.service
fleetctl submit /opt/data/fleet/elasticsearch/${DISCOVERY_NAME}@.service

echo "Starting new units"
for i in 1 2 3; do
  fleetctl start /opt/data/fleet/elasticsearch/${ES_NAME}@${i}.service
  sleep 15
  fleetctl start /opt/data/fleet/elasticsearch/${DISCOVERY_NAME}@${i}.service
  sleep 10
done;
