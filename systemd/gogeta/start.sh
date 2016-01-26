#!/bin/sh
GOGETA_VERSION=latest

/opt/data/tools/docker-clean.sh ${GOGETA_NAME} &> /dev/null

/usr/bin/docker pull quay.io/nuxeoio/gogeta:${GOGETA_VERSION}
/usr/bin/docker run --rm --name $GOGETA_NAME -p 7777:7777 -v /opt/data/gogeta-templates:/gogeta-templates quay.io/nuxeoio/gogeta:${GOGETA_VERSION} -templateDir /gogeta-templates -forceFwSsl=true -UrlHeaderParam nuxeo-virtual-host
echo "Container $GOGETA_NAME is running."
