PROJECT_NAME="coen-ed-randall"
IMAGE_NAME="edr-website-nginx"
CONTAINER_NAME="edr-website-nginx-container"

#Change this if needed, depending on the disto you're using.  For example, alpine only uses /bin/sh
SHELL_EXEC="/bin/bash"

#No need to edit anything below this line
#----------------------------------------

#The docker binary
DOCKER=$(which docker)

#The container we wish to manipulate with these scripts (via the Makefil)
TARGET=$($DOCKER ps -a | grep $CONTAINER_NAME | grep -v ^CONTAINER | awk {'print $1'})
