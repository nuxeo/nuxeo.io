#!/bin/bash -

if [ $# -lt 1 ]; then
  echo "Usage: $0 SERVICE"
  exit 1
fi

fleetctl list-units --no-legend | grep $1 > /dev/null
if [ ! $? -eq 0 ]; then
  echo "Unknown service"
  exit 2
fi

# wait until container is running
while ! [ `fleetctl list-units --no-legend -fields "unit,active" | grep $1 | awk '{print $2}'` = "active" ]
do
    echo "Waiting $1 service to be active, current state:"
    echo `fleetctl list-units --no-legend -fields "unit,machine,sub,active" | grep $1`
    sleep 60
done
