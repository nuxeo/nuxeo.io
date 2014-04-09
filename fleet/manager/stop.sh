#!/bin/sh

# Sometimes, container seems not yet stopped
docker ps | grep $MANAGER_NAME
if [ $? -eq 0 ]; then
  docker stop $MANAGER_NAME
fi
docker rm $MANAGER_NAME

docker ps -a | grep Exit | awk '{print $1}' | xargs docker rm
