#!/bin/bash

# Call to prevent stopping user container
# Write "stopdockerwatch" to sacred_proc_file
#
# Created by Bryzgalov Peter
# Copyright (c) 2013-2014 Riken AICS. All rights reserved

version="2.6.4"

stop_file="/tmp/dockeriaas_nostop"
counter_file="/tmp/dockeriaas_cc"
timeout=2

echo "Stop $version $stop_file"
exec 20<>$stop_file
flock -x -w 2 20
echo "0" > $stop_file
flock -u 20
echo "Exit nostop state"
# Start dockerwatch.sh
echo "Starting dockerwatch"
dockerwatch="/dockerwatch.sh $counter_file $stop_file $timeout >>/dockerwatch.log 2>&1"
eval "$dockerwatch"