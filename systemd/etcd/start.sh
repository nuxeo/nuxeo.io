#!/bin/sh

VIRT=$(coreos-detect-virt)
STATE=/var/lib/etcd-local
ARGS="-f -data-dir $STATE -bind-addr 0.0.0.0 -peer-bind-addr 0.0.0.0"
ETCD_TOKEN_FILE=/opt/data/etcd_token
IP=`/opt/data/tools/resolve-ip.sh`

if [ ! -f $ETCD_TOKEN_FILE ]; then
    curl https://discovery.etcd.io/new > $ETCD_TOKEN_FILE 2> /dev/null
fi

TOKEN=$(cat $ETCD_TOKEN_FILE)
ARGS="${ARGS} -peer-addr $IP:7001 -addr $IP:4001 -discovery $TOKEN -name ${HOSTNAME}"

exec /usr/bin/etcd $ARGS
