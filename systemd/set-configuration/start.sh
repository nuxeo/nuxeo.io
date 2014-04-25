#!/bin/sh

# Write defaultDnsSuffix for manager
/usr/bin/etcdctl set /config/manager/defaultDnsSuffix trial.nuxeo.io.dev
