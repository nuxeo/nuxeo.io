#!/bin/sh -x

# Nuxeo setup
nuxeouid=$(grep nuxeo /etc/passwd | cut -d: -f3)
nuxeogid=$(grep nuxeo /etc/passwd | cut -d: -f4)

wget -q "http://www.nuxeo.org/static/latest-snapshot/nuxeo,tomcat,zip,5.9" -O /tmp/nuxeo-distribution-tomcat.zip
wget -q "http://www.nuxeo.org/static/latest-io-snapshot/marketplace,nuxeo,io,zip,1.0" -O /tmp/marketplace-nuxeo.io.zip

mkdir -p /tmp/nuxeo-distribution
unzip -q -d /tmp/nuxeo-distribution /tmp/nuxeo-distribution-tomcat.zip
distdir=$(/bin/ls /tmp/nuxeo-distribution | head -n 1)
mkdir -p $NUXEO_HOME
mv /tmp/nuxeo-distribution/$distdir/* $NUXEO_HOME
rm -rf /tmp/nuxeo-distribution*
chmod +x $NUXEO_HOME/bin/nuxeoctl

mkdir -p /var/lib/nuxeo
mkdir -p /var/log/nuxeo
mkdir -p /var/run/nuxeo

chown -R $nuxeouid:$nuxeogid /var/lib/nuxeo
chown -R $nuxeouid:$nuxeogid /var/log/nuxeo
chown -R $nuxeouid:$nuxeogid /var/run/nuxeo
chown -R $nuxeouid:$nuxeogid /tmp/marketplace-nuxeo.io.zip

cat << EOF >> $NUXEO_HOME/bin/nuxeo.conf
nuxeo.log.dir=/var/log/nuxeo
nuxeo.pid.dir=/var/run/nuxeo
nuxeo.data.dir=/var/lib/nuxeo/data
nuxeo.wizard.done=true
EOF

# Install nuxeo.io MP
echo 'mp-init'
su $NUXEO_USER -m -c "$NUXEOCTL mp-init"
echo 'mp-install'
su $NUXEO_USER -m -c "$NUXEOCTL mp-install --accept true /tmp/marketplace-nuxeo.io.zip"

echo 'postgres'
# PostgreSQL setup
pg_dropcluster 9.3 main
LC_ALL=en_US.UTF-8 pg_createcluster --locale=en_US.UTF-8 --port=5432 9.3 nuxeodb
echo "kernel.shmmax = 301989888" >> /etc/sysctl.conf
pgconf="/etc/postgresql/9.3/nuxeodb/postgresql.conf"
perl -p -i -e "s/^#?shared_buffers\s*=.*$/shared_buffers = 100MB/" $pgconf
perl -p -i -e "s/^#?max_prepared_transactions\s*=.*$/max_prepared_transactions = 32/" $pgconf
perl -p -i -e "s/^#?effective_cache_size\s*=.*$/effective_cache_size = 1GB/" $pgconf
perl -p -i -e "s/^#?work_mem\s*=.*$/work_mem = 32MB/" $pgconf
perl -p -i -e "s/^#?wal_buffers\s*=.*$/wal_buffers = 8MB/" $pgconf
perl -p -i -e "s/^#?lc_messages\s*=.*$/lc_messages = 'en_US.UTF-8'/" $pgconf
perl -p -i -e "s/^#?lc_time\s*=.*$/lc_time = 'en_US.UTF-8'/" $pgconf
perl -p -i -e "s/^#?log_line_prefix\s*=.*$/log_line_prefix = '%t [%p]: [%l-1] '/" $pgconf
