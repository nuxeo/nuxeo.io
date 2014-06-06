#!/bin/sh -

if [ $# -lt 1 ]; then
  echo "Usage: $0 CONTAINER"
  exit 1
fi

# wait until container is running
while ! docker ps | grep -q "$1[^/]"
do
    echo "Waiting container $1..."
    sleep 3
done

sleep 2
