#!/bin/bash
# Run existing Docker Image and create + start a Docker Container
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
#     Needs to be combined with exporting '$DISPLAY' and running '$ xhost local:docker' before starting the container.
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
# License: MIT
# https://github.com/Pet-Series
#
#  - "kullken"      = DockerWeb User/Account
#  - "ros2_amd64"   = DockerWeb Repository
#  - "jazzy-full"   = DockerWeb Tag
#  - "kullken/ros2_amd64:jazzy-full" = Full Docker Image Name
#  - "jazzy-full-container"          = Local Docker Container Name
#
#  - ROS2 version: ROS2/Jazzy Jalisco(amd64/PC)
#  - OS version:   Ubuntu 24.04/noble(amd64/PC)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_amd64
#  - https://hub.docker.com/repository/docker/kullken/ros2_amd64/tags?name=jazzy
#  - https://hub.docker.com/r/osrf/ros/tags?page=1&name=jazzy
xhost local:docker
docker run \
  -it \
  --name jazzy-full-container \
  --env DISPLAY=$DISPLAY \
  --env HOSTUSER=$USER \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="/etc/localtime:/etc/localtime:ro" \
  --volume="/home/$USER/ws_ros2:/home/ubuntu/ws_ros2:rw" \
  --network=host \
  kullken/ros2_amd64:jazzy-full