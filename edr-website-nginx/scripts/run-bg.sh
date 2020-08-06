#!/bin/bash

#
# Script:  run-fg.sh
# Purpose: This script will run the target container in the foreground (defined in config/config.sh) - it should be called by the Makefile
#

#Pull in global variables from config/config.sh
. config/config.sh

echo $DOCKER run --name $CONTAINER_NAME -dp80:80 $IMAGE_NAME
$DOCKER run --name $CONTAINER_NAME -dp80:80 $IMAGE_NAME

echo 
echo $DOCKER docker ps -a
$DOCKER ps -a
echo 
