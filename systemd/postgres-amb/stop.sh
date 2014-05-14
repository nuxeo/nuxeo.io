#!/bin/sh

docker stop $POSTGRES_AMB_NAME

#docker ps -a | grep Exit | awk '{print $1}' | xargs docker rm
