#!/bin/bash -

# usage
show_help() {
cat << EOF
Usage: ${0##*/} [-hc] DOCKER_IMAGE_NAME
Build docker image named with the same name as the directory where it is. Also
push it to the local registry.

    -h          display this help and exit.
    -f          use --no-cache param while building image
EOF
}

# script variables
no_cache=

OPTIND=1 # Reset is necessary if getopts was used previously in the script.  It is a good idea to make this local in a function.
while getopts "hf" opt; do
    case "$opt" in
        h)
            show_help
            exit 0
            ;;
        f)  no_cache="--no-cache"
            ;;
        '?')
            show_help >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))" # Shift off the options and optional --.

if [ $# -lt 1 ]; then
  show_help >&2
  exit 1
fi

REGISTRY=`etcdctl get /services/docker-registry/1/location | sed -e 's/{"host":"\([^"]*\)","port":\([^"]*\)}/\1\:\2/'`

# Build image
/usr/bin/docker build $no_cache -t nuxeo/$1 /opt/data/docker/$1/

# Tag and push image on registry
/usr/bin/docker tag nuxeo/$1 $REGISTRY/nuxeo/$1
/usr/bin/docker push $REGISTRY/nuxeo/$1
