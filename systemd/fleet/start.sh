#!/bin/sh

export FLEET_PUBLIC_IP=`/opt/data/tools/resolve-ip.sh`
export FLEET_METADATA="nodetype=core"

exec /usr/bin/fleet -config="/media/state/etc/fleet.conf"
