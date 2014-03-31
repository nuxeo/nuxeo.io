#!/bin/sh

/usr/bin/docker run -p 22 -t -p 8080 --name ${ENV_TECH_ID} -e ENV_TECH_ID=${ENV_TECH_ID} ${DOCKER_REGISTRY}/nuxeo/iocontainer
