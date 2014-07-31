#!/bin/sh -x

# Launch sshd
/usr/sbin/sshd

# Create ROLE and DB
psql -h $DB_PORT_1337_TCP_ADDR -p $DB_PORT_1337_TCP_PORT -U postgres -t template1 -c '\du' | grep $PG_ROLE_NAME
if [ ! $? -eq 0 ]; then
  psql -h $DB_PORT_1337_TCP_ADDR -p $DB_PORT_1337_TCP_PORT -U postgres -t template1 --quiet -t -f- << EOF > /dev/null
    CREATE USER $PG_ROLE_NAME;
    CREATE DATABASE $PG_DB_NAME ENCODING 'UTF8';
    ALTER DATABASE $PG_DB_NAME OWNER TO $PG_ROLE_NAME;
EOF
fi

echo "ALTER USER $PG_ROLE_NAME WITH PASSWORD '$PG_PWD';" | psql -h $DB_PORT_1337_TCP_ADDR -p $DB_PORT_1337_TCP_PORT -U postgres

unset PGPASSWORD

NUXEO_CONF=$NUXEO_HOME/bin/nuxeo.conf

# PostgreSQL conf
perl -p -i -e "s/^#?(nuxeo.templates=.*$)/\1,postgresql/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.host=.*$/nuxeo.db.host=$DB_PORT_1337_TCP_ADDR/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.port=.*$/nuxeo.db.port=$DB_PORT_1337_TCP_PORT/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.name=.*$/nuxeo.db.name=$PG_DB_NAME/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.user=.*$/nuxeo.db.user=$PG_ROLE_NAME/g" $NUXEO_CONF
perl -p -i -e "s/^#?nuxeo.db.password=.*$/nuxeo.db.password=$PG_PWD/g" $NUXEO_CONF

# S3 conf
echo "nuxeo.core.binarymanager=org.nuxeo.ecm.core.storage.sql.S3BinaryManager" >> $NUXEO_CONF
echo "nuxeo.s3storage.bucket=$S3_BUCKET" >> $NUXEO_CONF
echo "nuxeo.s3storage.awsid=$S3_AWSID" >> $NUXEO_CONF
echo "nuxeo.s3storage.awssecret=$S3_AWSSECRET" >> $NUXEO_CONF
if [ $S3_AWSID = "nuxeo" ] ; then
  echo "nuxeo.s3storage.endpoint=http://$S3_PORT_1337_TCP_ADDR:$S3_PORT_1337_TCP_PORT" >> $NUXEO_CONF
fi
echo "nuxeo.s3storage.region=$S3_REGION" >> $NUXEO_CONF

# nuxeo.url
echo "nuxeo.url=$HTTP_PROTOCOL://$DOMAIN/nuxeo" >> $NUXEO_CONF

# connect.url
if [ ! -z "$CONNECT_URL" ]; then
  echo "org.nuxeo.connect.url=$CONNECT_URL" >> $NUXEO_CONF
fi


echo "org.nuxeo.dev=true" >> $NUXEO_CONF

# instance.clid
printf "%b\n" "$CLID" >> /var/lib/nuxeo/data/instance.clid

# Install packages if exist
if [ ! -z "$PACKAGES" ]; then
  su $NUXEO_USER -m -c "$NUXEOCTL mp-install $PACKAGES --accept=true"
fi

# Start nuxeo
su $NUXEO_USER -m -c "$NUXEOCTL --quiet start"
su $NUXEO_USER -m -c "tail -f /var/log/nuxeo/server.log"
