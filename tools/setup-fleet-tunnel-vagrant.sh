#!/bin/bash

CORE=${1:-nxio-core-01}

vagrant ssh-config $CORE | sed -n "s/IdentityFile//gp" | xargs ssh-add
export FLEETCTL_TUNNEL="$(vagrant ssh-config $CORE | sed -n "s/[ ]*HostName[ ]*//gp"):$(vagrant ssh-config $CORE | sed -n "s/[ ]*Port[ ]*//gp")"
echo $FLEETCTL_TUNNEL
