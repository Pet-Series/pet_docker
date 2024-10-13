#!/bin/bash
# Launch from Docker image
# 
set -e
source /opt/ros/noetic/setup.bash
source /opt/ros/galactic/setup.bash
#source /home/pet/ws_ros2-galactic/install/setup.bash
exec "$@"