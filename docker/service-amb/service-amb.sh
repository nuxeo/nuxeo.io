#!/bin/bash

SERV=$1
/usr/local/go/src/github.com/arkenio/etcd-netfw/etcd-netfw -servicePath /services/${SERV} -etcdAddress http://172.17.42.1:4001
