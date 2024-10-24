#!/bin/bash
# Docker 'ENTRYPOINT' = To configure the executables that will always run after the container is initiated (not by '$ docker exec')
# Initiates all necessary ROS2-stuff

set -e  # 'set -e' stops the execution of this script if a command or pipeline has an error - which is the opposite of the default shell behaviour, which is to ignore errors in scripts. 
echo " >>>> My mixed ROS1/Noetic & ROS2/Galactic stuff '~/ros-entrypoint.sh' file  <<<<"

source /opt/ros/noetic/setup.bash
source /opt/ros/galactic/setup.bash
# source /home/pet/ws_ros2-galactic/install/setup.bash
exec "$@"