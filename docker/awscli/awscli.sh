#!/bin/sh -

/bin/write-awscli-conf.sh

exec /usr/bin/aws $@
