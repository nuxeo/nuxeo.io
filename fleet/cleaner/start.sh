#!/bin/sh -

BASE_PATH=`dirname $0`
UNITNAME=nxio@`echo $SERVICE_ID | cut -d_ -f2`.service

/usr/bin/fleetctl destroy $UNITNAME

while [ `etcdctl get /services/$SERVICE_ID/1/status/current` != "stopped" ]; do
	echo "Waiting for service to stop"; sleep 5;
done

echo "Deleting entries for $SERVICE_ID"
for SERVICE in "$@"
do
    echo "Cleaning $SERVICE:"
    CLEANER="$BASE_PATH/$SERVICE-cleaner.sh"
    if [ -f $CLEANER ]; then
        $CLEANER
    else
        echo "Warning: Unknown service $SERVICE."
    fi
done
