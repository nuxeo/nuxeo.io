#!/bin/sh

if [ -f /tmp/postgres-amb-local ]; then
  /usr/bin/docker stop `/bin/cat /tmp/postgres-amb-local`
  /bin/rm /tmp/postgres-amb-local
fi
