#!/bin/sh -
echo "Destroying old units"
for i in 1 2 3; do
  fleetctl destroy elasticsearch@${i}.service
  fleetctl destroy elasticdiscovery@${i}.service
done

fleetctl destroy /opt/data/fleet/elasticsearch/elasticsearch@.service
fleetctl submit /opt/data/fleet/elasticsearch/elasticsearch@.service

fleetctl destroy /opt/data/fleet/elasticsearch/elasticdiscovery@.service
fleetctl submit /opt/data/fleet/elasticsearch/elasticdiscovery@.service

echo "Starting new units"
for i in 1 2 3; do
  fleetctl start /opt/data/fleet/elasticsearch/elasticsearch@${i}.service
  sleep 15
  fleetctl start /opt/data/fleet/elasticsearch/elasticdiscovery@${i}.service
  sleep 10
done;
