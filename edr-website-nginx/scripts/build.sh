#!/bin/bash

#
# Script:  build.sh
# Purpose: this script will build (docker build -t $IMAGENAME) the target container which is defined in config/config.sh - it should be called by the Makefile
#

#Pull in global variables from config/config.sh
. config/config.sh

echo $DOCKER build -t gcr.io/$PROJECT_NAME/$IMAGE_NAME:v2 .
$DOCKER build -t gcr.io/$PROJECT_NAME/$IMAGE_NAME:v2 .


echo
echo $DOCKER images
$DOCKER images
echo

