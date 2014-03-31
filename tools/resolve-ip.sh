#!/bin/sh

if [ `coreos-detect-virt` =  "ec2" ] ; then
  echo `curl http://169.254.169.254/latest/meta-data/local-ipv4`
else
  echo `ifconfig | awk '/192.168.2.255/ {print $2}'`
fi
