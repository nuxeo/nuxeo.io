#!/bin/sh

sleep 120

# gogeta
echo "Starting gogeta"
/usr/bin/systemctl restart gogeta.service
echo "Started gogeta"

# ambs
echo "Starting postgres amb"
/usr/bin/systemctl restart postgres-amb.service
echo "Started postgres amb"

echo "Starting s3 amb"
/usr/bin/systemctl restart s3-amb.service
echo "Started s3 amb"
