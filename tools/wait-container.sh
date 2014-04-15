#!/bin/sh -

# wait until container is running
while ! docker ps | grep -q $1
do
    sleep 2
done
