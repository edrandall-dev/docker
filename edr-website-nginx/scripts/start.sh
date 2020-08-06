#!/bin/bash

#
# Script:  start.sh
# Purpose: this script will start (docker start) the target container which is defined in config/config.sh - it should be called by the Makefile
#

#Pull in global variables from config/config.sh
. config/config.sh

echo $DOCKER start $TARGET
$DOCKER start $TARGET

echo
echo $DOCKER ps -a
$DOCKER ps -a
echo
