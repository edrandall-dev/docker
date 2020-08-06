#!/bin/bash

#
# Script:  stop.sh
# Purpose: this script will stop (docker stop) the target container which is defined in config/config.sh - it should be called by the Makefile
#

#Pull in global variables from config/config.sh
. config/config.sh

echo "$DOCKER stop $TARGET"
$DOCKER stop $TARGET

echo
echo $DOCKER ps -a
$DOCKER ps -a
echo 
