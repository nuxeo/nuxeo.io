#!/bin/sh -

GIT_ROOT=/opt/data

if [ $# -lt 1 ]; then
  echo "Usage: $0 TAG"
  exit 1
fi

if [ ! -w $GIT_ROOT ]; then
  echo "You don't have enough rights on $GIT_ROOT to execute this script.";
  exit 2
fi

exec git stash && git pull --all && git checkout $0 && git stash pop
