#!/bin/sh

docker stop $S3_AMB_NAME

#docker ps -a | grep Exit | awk '{print $1}' | xargs docker rm
