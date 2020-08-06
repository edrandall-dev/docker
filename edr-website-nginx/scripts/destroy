#!/bin/bash

#
# Script:  destroy.sh
# Purpose: this script will destroy (docker rm -f) the target container and remove the local image which is defined in config/config.sh - it should be called by the Makefile
#

#Pull in global variables from config/config.sh
. config/config.sh

echo $DOCKER rm -f $TARGET
$DOCKER rm -f $TARGET

sleep 1

echo $DOCKER rmi -f $($DOCKER images | grep $IMAGE_NAME | awk {'print $3'})
$DOCKER rmi -f $($DOCKER images | grep $IMAGE_NAME | awk {'print $3'})

echo
echo $DOCKER images
$DOCKER images
echo 


