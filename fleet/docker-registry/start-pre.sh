#!/bin/sh

echo "pull-image"

# Pulling registry image from docker registry
exec /usr/bin/docker pull registry:${REGISTRY_VERSION}
