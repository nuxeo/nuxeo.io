#!/bin/sh

sleep 60

# gogeta
echo "Starting gogeta"
sudo /usr/bin/systemctl restart gogeta.service
echo "Started gogeta"

# datadog agent
echo "Starting Datadog agent"
cp -f /opt/data/systemd/datadog/datadog.service /etc/systemd/system/
sudo /usr/bin/systemctl restart datadog.service

# ambs
# echo "Starting postgres amb"
# sudo /usr/bin/systemctl restart postgres-amb.service
# echo "Started postgres amb"

# echo "Starting s3 amb"
# sudo /usr/bin/systemctl restart s3-amb.service
# echo "Started s3 amb"
