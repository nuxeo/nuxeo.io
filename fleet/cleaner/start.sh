#!/bin/sh -

BASE_PATH=`dirname $0`
UNITNAME=nxio@`echo $SERVICE_ID | cut -d_ -f2`.service

if [ ! -x /usr/bin/fleetctl ]; then
    echo "Error: fleetctl not available"
    exit 1
fi

if [ ! -x /usr/bin/etcdctl ]; then
    echo "Error: etcdctl not available"
    exit 1
fi


/usr/bin/fleetctl destroy $UNITNAME
i=0
while [ `etcdctl get /services/$SERVICE_ID/1/status/current` != "stopped" ]; do
    echo "Waiting for service to stop"
    sleep 5
    i=$((i+1))
	if [ $i -eq 20 ]; then
        echo "Timeout waiting for service to stop, exiting in error"
		exit 1;
	fi
done

echo "Deleting entries for $SERVICE_ID"
for SERVICE in "$@"
do
    echo "Cleaning $SERVICE:"

    CLEANER="$BASE_PATH/$SERVICE-cleaner.sh"
    if [ -f $CLEANER ]; then
        $CLEANER
    else
        echo "Warning: No cleaner for service $SERVICE."
    fi
done
