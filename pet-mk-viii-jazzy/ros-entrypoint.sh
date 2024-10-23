#!/bin/bash
# Docker 'ENTRYPOINT' = To configure the executables that will always run after the container is initiated (not by '$ docker exec')
# Initiates all necessary ROS2-stuff
set -e  # 'set -e' stops the execution of this script if a command or pipeline has an error - which is the opposite of the default shell behaviour, which is to ignore errors in scripts. 
echo " >>>> My $ROS_DISTRO stuff '~/ros-entrypoint.sh' file  <<<<"

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
# source /home/pet/ws_ros2/install/setup.bash
exec "$@"