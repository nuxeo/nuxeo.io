#!/bin/sh -
echo "Destroying old units"
for i in 1 2 3; do
  fleetctl destroy elasticsearch-${i}.service
  fleetctl destroy elastic-discovery-${i}.service
done

echo "Starting new units"
for i in 1 2 3; do
  fleetctl start /opt/data/fleet/elasticsearch/elasticsearch-${i}.service
  sleep 15
  fleetctl start /opt/data/fleet/elasticsearch/elastic-discovery-${i}.service
  sleep 10
done;
