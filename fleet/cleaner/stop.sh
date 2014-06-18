#!/bin/sh -

# Cleanup temporary fleet unit
/usr/bin/fleetctl destroy ${FLEET_UNIT_NAME}
