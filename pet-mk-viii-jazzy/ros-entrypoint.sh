#!/bin/bash
# Docker 'ENTRYPOINT' = To configure the executables that will always run after the container is initiated (not by '$ docker exec')
# Initiates all necessary ROS2-stuff
set -e  # 'set -e' stops the execution of this script if a command or pipeline has an error - which is the opposite of the default shell behaviour, which is to ignore errors in scripts. 
echo " >>>> Start: My $ROS_DISTRO stuff '~/ros-entrypoint.sh' file  <<<<"

# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
# if [ -f /ws_ros2-base/devel/setup.bash ]
# then
#   source /ws_ros2-base/devel/setup.bash
# fi
# if [ -f /ws_ros2-overlay/devel/setup.bash ]
# then
#   source /ws_ros2-overlay/devel/setup.bash
# fi
# echo " <<<<< Done: My $ROS_DISTRO stuff '~/ros-entrypoint.sh' file  >>>>"

# source /home/pet/ws_ros2/install/setup.bash
exec "$@"