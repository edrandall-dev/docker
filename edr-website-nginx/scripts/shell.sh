#!/bin/bash

#
# Script:  shell.sh
# Purpose: run a shell on the target container  which is defined in config/config.sh - it should be called by the Makefile
#

#Pull in global variables from config/config.sh
. config/config.sh

$DOCKER exec -it $CONTAINER_NAME $SHELL_EXEC


