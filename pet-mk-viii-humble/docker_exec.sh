#!/bin/bash
# Start new bash/terminal in existing custom Docker Container.
#
# Prerequisite - On docker host: 
#   I) Raspberry Pi(arm64v8) with Ubuntu & Docker installed.
#  II) Docker Container with name 'pet-mk-viii-humble_container' is Up or Paused.
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/humble(arm64v8)
#  - OS version:   Ubuntu 22.04/jammy(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble
docker exec  \
    --interactive \
    --tty \
    --env HOSTUSER=${USER} \
    pet-mk-viii-humble_container \
    /home/pet/ros_entrypoint.sh bash