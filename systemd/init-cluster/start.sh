#!/bin/sh

# gogeta
echo "Building 'gogeta' image"
/usr/bin/docker build -t nuxeo/gogeta /opt/data/docker/reverse-proxy
echo "Image 'gogeta' built"
echo "Starting gogeta"
/usr/bin/systemctl start gogeta.service
echo "Started gogeta"


# ambs
echo "Building 'service-amb' image"
/usr/bin/docker build -t nuxeo/service-amb /opt/data/docker/service-amb
echo "Image 'service-amb' built"

echo "Starting postgres amb"
/usr/bin/systemctl start postgres-amb.service
echo "Started postgres amb"

echo "Starting s3 amb"
/usr/bin/systemctl start s3-amb.service
echo "Started s3 amb"

# fleet units

INITIALIZED=`/usr/bin/etcdctl get /arken.io/initialized`
if [ $? -eq 0 ]; then
  exit 0
fi
/usr/bin/etcdctl set /arken.io/initialized true

fleetctl start /opt/data/fleet/docker-registry/docker-registry.service
/opt/data/tools/wait-fleet-unit.sh docker-registry.service

# start postgres and vblob only on Vagrant
VIRT=`systemd-detect-virt`
if [ $VIRT = "oracle" ] ; then
  fleetctl start /opt/data/fleet/postgres-service/postgres-service.service
  /opt/data/tools/wait-fleet-unit.sh postgres-service.service

  fleetctl start /opt/data/fleet/vblob-service/vblob-service.service
  /opt/data/tools/wait-fleet-unit.sh vblob-service.service
fi

fleetctl start /opt/data/fleet/build-io-base/build-io-base.service
/opt/data/tools/wait-fleet-unit.sh build-io-base.service

fleetctl start /opt/data/fleet/build-io-container/build-io-container.service
/opt/data/tools/wait-fleet-unit.sh build-io-container.service

fleetctl start /opt/data/fleet/manager/manager.service
/opt/data/tools/wait-fleet-unit.sh manager.service
