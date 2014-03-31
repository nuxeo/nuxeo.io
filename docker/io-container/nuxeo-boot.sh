#!/bin/sh -x

su $NUXEO_USER -m -c "$NUXEOCTL --quiet restart"
