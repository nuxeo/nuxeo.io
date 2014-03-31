#!/bin/bash
# Regenerate etcd_token file to remove orphan client
TOKEN_FILE=etcd_token

# Assuming resetEtcd script is on the same dir that etcd_token file
DIR_NAME=`dirname ${BASH_SOURCE[0]}`
TOKEN_DIR=`cd $DIR_NAME/.. && pwd`
TOKEN_PATH=$TOKEN_DIR/$TOKEN_FILE

curl https://discovery.etcd.io/new > $TOKEN_PATH 2> /dev/null
