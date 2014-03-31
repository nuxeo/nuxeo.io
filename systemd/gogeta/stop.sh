#!/bin/sh

if [ -f /tmp/gogeta-local ]; then
  /usr/bin/docker stop `/bin/cat /tmp/gogeta-local`
  /bin/rm /tmp/gogeta-local
fi
