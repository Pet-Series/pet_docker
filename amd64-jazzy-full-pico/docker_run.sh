#!/bin/bash
# Run existing Docker Image and create + start a Docker Container
# - AMD64/x86 CPU Architecture
# - ROS Version: ROS2 20.24   LTS (AMD64) aka."jazzy"
# - OS version : Ubuntu 24.04 LTS (AMD64) aka."noble"
#  - Source Image = osrf/ros:jazzy-desktop-full
#  - Target Container = jazzy-full-container
#
#  1) Mount your local docker-host </home/{$USER}>-folder into the container
#     This means your local docker-host ~/bashrc will be executed.
#  2) Mount local docker host </etc/group + /etc/passwd + ...etc.>
#     To offer seamless right & user/group ID.
#  3) Mount local docker host </etc/localtime>
#     To ensure that the host and container have the same time zone
#  4) Mount local docker host </tmp/.X11-unix>
#     To enable GUI/X11 applications inside container
#     Needs to be combined with exporting '$DISPLAY' and running '$ xhost local:docker' before starting the conatiner.
#
# --------A few other commands that may be useful to know.... 
# docker exec -it jazzy-full-container bash
# docker container pause jazzy-full-container
# docker container stop jazzy-full-container
# docker container restart jazzy-full-container
# docker container kill jazzy-full-container
# docker container rm jazzy-full-container
# docker container prune 
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#----------------------
# More info: https://github.com/Pet-Series/pet_docker
# More info: https://hub.docker.com/repositories/kullken
xhost local:docker
docker run \
  -it \
  --privileged \
  --name jazzy-full-pico-container \
  --env DISPLAY=$DISPLAY \
  --env HOSTUSER=$USER \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="/etc/localtime:/etc/localtime:ro" \
  --volume="/media:/media:rw" \
  --volume="/home/$USER/ws_ros2:/home/ubuntu/ws_ros2:rw" \
  --network=host \
  kullken/ros2_amd64:jazzy-full-pico