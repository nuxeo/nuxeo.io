#!/bin/sh -x

# Nuxeo setup
wget -q "http://www.nuxeo.org/static/latest-release/nuxeo,tomcat.zip,5.9.4" -O /tmp/nuxeo-distribution-tomcat.zip
wget -q "http://www.nuxeo.org/static/latest-io-release/marketplace,nuxeo,io,zip,0.1" -O /tmp/marketplace-nuxeo.io.zip

mkdir -p /tmp/nuxeo-distribution
unzip -q -d /tmp/nuxeo-distribution /tmp/nuxeo-distribution-tomcat.zip
distdir=$(/bin/ls /tmp/nuxeo-distribution | head -n 1)
mkdir -p $NUXEO_HOME
mv /tmp/nuxeo-distribution/$distdir/* $NUXEO_HOME
rm -rf /tmp/nuxeo-distribution*
chmod +x $NUXEO_HOME/bin/nuxeoctl

# Patch nuxeo-platform-oauth with a newer version. TO BE REMOVED WHEN IN 5.9.5
OAUTH_JAR=$(/bin/ls $NUXEO_HOME/nxserver/bundles/nuxeo-platform-oauth* | head -n 1)
wget -q "https://maven-eu.nuxeo.org/nexus/service/local/repositories/public-snapshots/content/org/nuxeo/ecm/platform/nuxeo-platform-oauth/5.9.5-SNAPSHOT/nuxeo-platform-oauth-5.9.5-20140806.021345-36.jar" -O $OAUTH_JAR

mkdir -p /var/lib/nuxeo
mkdir -p /var/log/nuxeo
mkdir -p /var/run/nuxeo

chown -R $NUXEO_USER:$NUXEO_USER /var/lib/nuxeo
chown -R $NUXEO_USER:$NUXEO_USER /var/log/nuxeo
chown -R $NUXEO_USER:$NUXEO_USER /var/run/nuxeo
chown -R $NUXEO_USER:$NUXEO_USER /tmp/marketplace-nuxeo.io.zip

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
