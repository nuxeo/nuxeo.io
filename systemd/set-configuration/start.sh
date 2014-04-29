#!/bin/sh

# Write config for manager in dev
/usr/bin/etcdctl set /services/manager/domain manager.trial.nuxeo.io.dev
/usr/bin/etcdctl set /services/manager/defaultDnsSuffix trial.nuxeo.io.dev
