#!/bin/sh -

if [ $# -gt 0 ]; then
  # Ensure to rm not correctly stopped container
  docker ps -a | grep "$1[^/]"
  if [ $? -eq 0 ]; then
    docker rm -f $1
  fi
fi

# Clean exited container
docker ps -a|grep Exit|awk '{print $1}'|xargs docker rm

# Clean orphan images
# XXX Should be handle in a different way still we understand better the docker regsitry.
# docker images|grep none|awk '{print $3}'|xargs docker rmi

exit 0
