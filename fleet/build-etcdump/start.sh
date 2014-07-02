#!/bin/sh

/opt/data/tools/build-image.sh etcdump
echo "etcdump pushed."

/opt/data/tools/build-image.sh etcdrestore
echo "etcdrestore pushed."
