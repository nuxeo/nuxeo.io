#!/bin/sh

# gogeta
echo "Starting gogeta"
/usr/bin/systemctl start gogeta.service
echo "Started gogeta"

# passivator
echo "Starting passivator"
/usr/bin/systemctl start passivator.service
echo "Started passivator"

# ambs
echo "Starting postgres amb"
/usr/bin/systemctl start postgres-amb.service
echo "Started postgres amb"

echo "Starting s3 amb"
/usr/bin/systemctl start s3-amb.service
echo "Started s3 amb"
