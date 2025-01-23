#!/bin/bash
#  - Docker 'ENTRYPOINT' = To configure the executables that will always run after the container is initiated (not by '$ docker exec')
#  - Initiates all necessary ROS2-stuff
#
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/jazzy(arm64v8)
#  - OS version:   Ubuntu 24.04/noble(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://github.com/Pet-Series/Pet-Mk-VIII

set -e  # 'set -e' stops the execution of this script if a command or pipeline has an error - which is the opposite of the default shell behaviour, which is to ignore errors in scripts. 
echo " >>>> Start: My $ROS_DISTRO stuff in '~/ros-entrypoint.sh' file  <<<<"
ROS_LOCAL_WS=$HOME/ws_ros2

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
if [ -f  ]
then
    echo " >>>> Source local file: $ROS_LOCAL_WS/install/setup.bash"
    source $ROS_LOCAL_WS/install/setup.bash
fi

echo " <<<< Done: My $ROS_DISTRO stuff in '~/ros-entrypoint.sh' file  >>>>"

exec "$@"