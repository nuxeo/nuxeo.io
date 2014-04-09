#!/bin/sh -x

# Start nuxeo
su $NUXEO_USER -m -c "$NUXEOCTL --quiet restart"
