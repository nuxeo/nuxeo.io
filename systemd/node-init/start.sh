#!/bin/sh -

copy_service() {
  echo "Copying $1 service."
  cp -f /opt/data/systemd/$1/*.service /etc/systemd/system/
  systemctl daemon-reload
}

start_service() {
  echo "Starting $1 service."
  SERVICES=`find /opt/data/systemd/$1/*.service -printf "%f "`
  /usr/bin/systemctl restart $SERVICES
}

sleep 60

# gogeta
echo "Starting gogeta"
sudo /usr/bin/systemctl restart gogeta.service
echo "Started gogeta"

# datadog agent
copy_service datadog
start_service datadog

# journald-wrapper agent
copy_service journald-wrapper
start_service journald-wrapper

# ambs
# echo "Starting postgres amb"
# sudo /usr/bin/systemctl restart postgres-amb.service
# echo "Started postgres amb"

# echo "Starting s3 amb"
# sudo /usr/bin/systemctl restart s3-amb.service
# echo "Started s3 amb"
