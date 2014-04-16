#!/bin/sh -x

# Launch sshd
/usr/sbin/sshd

# Create ROLE and DB
PGPASSWORD=nuxeoiopostgres
psql -h $DB_PORT_1337_TCP_ADDR -p $DB_PORT_1337_TCP_PORT -U postgres -t template1 -c '\du' | grep $PG_ROLE_NAME
if [ ! $? -eq 0 ]; then
  psql -h $DB_PORT_1337_TCP_ADDR -p $DB_PORT_1337_TCP_PORT -U postgres -t template1 --quiet -t -f- << EOF > /dev/null
    CREATE USER $PG_ROLE_NAME;
    CREATE DATABASE $PG_DB_NAME ENCODING 'UTF8' OWNER $PG_ROLE_NAME;
EOF
fi

psql -h $DB_PORT_1337_TCP_ADDR -p $DB_PORT_1337_TCP_PORT -U postgres -t template1 --quiet -t -f- << EOF > /dev/null
    ALTER USER $PG_ROLE_NAME WITH PASSWORD '$PG_PWD';
EOF

NUXEO_CONF=$NUXEO_HOME/bin/nuxeo.conf
perl -p -i -e "s/^#?(nuxeo.templates=.*$)/\1,postgresql/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.host=.*$/nuxeo.db.host=$DB_PORT_1337_TCP_ADDR/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.port=.*$/nuxeo.db.port=$DB_PORT_1337_TCP_PORT/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.name=.*$/nuxeo.db.name$PG_DB_NAME/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.user=.*$/nuxeo.db.user=$PG_ROLE_NAME/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.password=.*$/nuxeo.db.password$PG_PWD/g" $NUXEO_CONF

# Start nuxeo
su $NUXEO_USER -m -c "$NUXEOCTL --quiet console"
