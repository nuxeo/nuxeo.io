#!/bin/sh

/usr/bin/docker build -t nuxeo/gogeta /opt/data/docker/reverse-proxy
/usr/bin/docker run --cidfile="/tmp/gogeta-local" -p 7777:7777 nuxeo/gogeta
