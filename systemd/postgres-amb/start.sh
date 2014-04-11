#!/bin/sh

/usr/bin/docker run --cidfile="/tmp/postgres-amb-local" --name postgres-amb -d -p 5432 nuxeo/service-amb postgres
