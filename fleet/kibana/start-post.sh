#!/bin/sh -

/opt/data/tools/wait-container.sh ${KIBANA_NAME}
PORT=`docker port ${KIBANA_NAME} ${DOORMAN_PORT} | awk -F : '{print $2}'`
/opt/data/tools/register-service.sh $KIBANA_NAME $PORT

DOMAIN=kibana.`etcdctl get /services/manager/config/defaultDomainSuffix`
/usr/bin/etcdctl set /domains/$DOMAIN/type service
/usr/bin/etcdctl set /domains/$DOMAIN/value ${KIBANA_NAME}
