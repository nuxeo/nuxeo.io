#!/bin/sh

## Setup fleet
FLEET_CONF_TEMPLATE="/opt/data/vagrant/fleet.conf.core"

IP=`/opt/data/tools/resolve-ip.sh`
sed -e "s/##IP##/$IP/g" $FLEET_CONF_TEMPLATE > /media/state/etc/fleet.conf

## Setup etcd
mkdir -p /media/state/overlays/var/lib/etcd-local
chown core:core /media/state/overlays/var/lib/etcd-local

cp /opt/data/systemd/*/*local.service /media/state/units/
chown core:core /media/state/units/*.service
chmod 644 /media/state/units/*.service

systemctl daemon-reload
systemctl restart local-enable.service
