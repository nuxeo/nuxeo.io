#!/bin/bash -

if [ $# -lt 1 ]; then
  echo "Usage: $0 SERVICE"
  exit 1
fi

fleetctl list-units | grep $1 > /dev/null
if [ ! $? -eq 0 ]; then
  echo "Unknown service"
  exit 2
fi

# wait until container is running
while ! [ `fleetctl list-units | grep $1 | awk '{print $4}'` = "active" ]
do
    echo "Waiting $1 service to be active, current state:"
    echo `fleetctl list-units | grep $1 | awk '{print $1,$2,$4}'`
    sleep 60
done
