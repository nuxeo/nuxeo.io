#!/bin/sh -x

# Launch sshd
/usr/sbin/sshd -D

# Create ROLE and DB
PGPASSWORD=nxiopostgres
psql -h $DB_PORT_5432_TCP_ADDR -p $DB_PORT_5432_TCP_PORT -U postgres -t template1 -c '\du' | grep $DB_NAME
if [ ! $? -eq 0 ]; then
  psql -h $DB_PORT_5432_TCP_ADDR -p $DB_PORT_5432_TCP_PORT -U postgres -t template1 --quiet -t -f-" << EOF > /dev/null
    CREATE USER $PG_ROLE_NAME;
    CREATE DATABASE $PG_DB_NAME ENCODING 'UTF8' OWNER $PG_ROLE_NAME;
EOF
fi

psql -h $DB_PORT_5432_TCP_ADDR -p $DB_PORT_5432_TCP_PORT -U postgres -t template1 --quiet -t -f-" << EOF > /dev/null
    ALTER USER $PG_ROLE_NAME WITH PASSWORD '$PG_PWD';
EOF

cat << EOF >> $NUXEO_HOME/bin/nuxeo.conf
nuxeo.templates=postgresql
nuxeo.db.host=$DB_PORT_5432_TCP_ADDR
nuxeo.db.port=$DB_PORT_5432_TCP_PORT
nuxeo.db.name=$PG_DB_NAME
nuxeo.db.user=$PG_ROLE_NAME
nuxeo.db.password=$PG_PWD
EOF

# Start nuxeo
su $NUXEO_USER -m -c "$NUXEOCTL --quiet console"
