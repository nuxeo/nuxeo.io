#!/bin/sh -x

# Nuxeo setup
wget -q "https://github.com/coreos/fleet/releases/download/v0.2.0/fleet-v0.2.0-linux-amd64.tar.gz" -O /tmp/fleetctl.tar.gz
tar -C /tmp/ -xf /tmp/fleetctl.tar.gz
mv /tmp/fleet-v* /tmp/fleet
cp /tmp/fleet/fleetctl /usr/bin/
