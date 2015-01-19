#!/bin/sh -

if [ $# -gt 0 ]; then
  # Ensure to rm not correctly stopped container
  docker ps -a | grep "$1[^/]"
  if [ $? -eq 0 ]; then
    docker rm -f $1
  fi
fi

# Clean exited container
docker ps -aq -f status=exited | awk '{print $1}' | xargs docker rm &> /dev/null

# Clean orphan images
docker images | grep none | awk '{print $3}' | xargs docker rmi &> /dev/null

exit 0
