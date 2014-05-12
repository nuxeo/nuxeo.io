#!/bin/sh

echo "pull-image"

# Pulling registry image from docker registry
/usr/bin/docker pull registry:${REGISTRY_VERSION}

echo "images pulled"
