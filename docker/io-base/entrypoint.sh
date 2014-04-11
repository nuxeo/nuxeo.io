#!/bin/sh -x

/usr/sbin/sshd -D

cat << EOF >> $NUXEO_HOME/bin/nuxeo.conf
nuxeo.templates=postgresql
nuxeo.db.host=$DB_PORT_5432_TCP_ADDR
nuxeo.db.port=$DB_PORT_5432_TCP_PORT
nuxeo.db.name=$ENV_TECH_ID
nuxeo.db.user=$ENV_TECH_ID
nuxeo.db.password=$PG_PWD
EOF

# Start nuxeo
su $NUXEO_USER -m -c "$NUXEOCTL --quiet console"
