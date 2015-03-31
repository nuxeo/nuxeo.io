#!/bin/sh
VIRT=`systemd-detect-virt`
if [ $VIRT = "ec2" -o $VIRT = "xen" ] ; then
  echo `curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
else
  echo `ifconfig | awk '/172.12.8.255/ {print $2}'`
fi
