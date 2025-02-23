#!/bin/bash
# Start new bash/terminal in existing custom Docker 'Base' Image.
#
# Prerequisite - On docker host: 
#   I) PC(amd64) with Ubuntu & Docker installed.
#  II) Docker Container with name 'jazzy-full-container' is Up or Paused.
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

ROS_DISTRO=jazzy
xhost local:docker
docker exec \
    --interactive \
    --tty \
    --env HOSTUSER=$USER \
    $ROS_DISTRO-full-container \
    bash