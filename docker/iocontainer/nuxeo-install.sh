#!/bin/sh -x

# Nuxeo setup

wget -q "http://www.nuxeo.org/static/latest-io-release/nuxeo,io,tomcat,zip,5.9.5" -O /tmp/nuxeo-distribution-tomcat.zip

mkdir -p /tmp/nuxeo-distribution
unzip -q -d /tmp/nuxeo-distribution /tmp/nuxeo-distribution-tomcat.zip
distdir=$(/bin/ls /tmp/nuxeo-distribution | head -n 1)
mkdir -p $NUXEO_HOME
mv /tmp/nuxeo-distribution/$distdir/* $NUXEO_HOME
rm -rf /tmp/nuxeo-distribution*
chmod +x $NUXEO_HOME/bin/nuxeoctl

# Patch nuxeo-platform-web-common with a newer version. TO BE REMOVED ASAP
rm -fv $NUXEO_HOME/nxserver/bundles/nuxeo-platform-web-common-*
wget -q "https://maven-us.nuxeo.org/nexus/service/local/repositories/public-releases/content/org/nuxeo/ecm/platform/nuxeo-platform-web-common/5.9.5.1/nuxeo-platform-web-common-5.9.5.1.jar" -P $NUXEO_HOME/nxserver/bundles
## end patch

mkdir -p /var/lib/nuxeo
mkdir -p /var/lib/nuxeo/data
mkdir -p /var/log/nuxeo
mkdir -p /var/run/nuxeo

chown -R $NUXEO_USER:$NUXEO_USER /var/lib/nuxeo
chown -R $NUXEO_USER:$NUXEO_USER /var/log/nuxeo
chown -R $NUXEO_USER:$NUXEO_USER /var/run/nuxeo

cat << EOF >> $NUXEO_HOME/bin/nuxeo.conf
nuxeo.log.dir=/var/log/nuxeo
nuxeo.pid.dir=/var/run/nuxeo
nuxeo.data.dir=/var/lib/nuxeo/data
nuxeo.wizard.done=true
EOF

# move installAfterRestart.log to correct data folder
mv $NUXEO_HOME/nxserver/data/installAfterRestart.log /var/lib/nuxeo/data/
