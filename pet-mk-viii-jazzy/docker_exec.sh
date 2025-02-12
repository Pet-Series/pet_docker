#!/bin/bash
# Start new bash/terminal in existing custom Docker 'Overlay' Container.
#
# Prerequisite - On docker host: 
#   I) Raspberry Pi(arm64v8) with Ubuntu & Docker installed.
#  II) Docker Container with name 'pet-mk-viii-jazzy_container' is Up or Paused.
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
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=jazzy

docker exec \
    --interactive \
    --tty \
    pet-mk-viii-jazzy_container \
    /home/pet/ros_entrypoint.sh bash