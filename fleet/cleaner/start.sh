#!/bin/sh -

BASE_PATH=`dirname $0`

echo "Deleting entries for $SERVICE_ID"
for SERVICE in "$@"
do
    echo "Cleaning $SERVICE:"
    CLEANER="$BASE_PATH/$SERVICE-cleaner.sh"
    if [ -f $CLEANER ]; then
        $CLEANER
    else
        echo "Warning: Unknown service $SERVICE."
    fi
done
