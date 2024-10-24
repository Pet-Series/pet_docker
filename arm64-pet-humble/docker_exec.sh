#!/bin/bash
# Start bash in existing container (Status Up/Paused).
#
# Prerequisite - On docker host: 
#   I) Raspberry Pi(arm64v8) with Ubuntu & Docker installed.
#  II) Docker Container with name 'pet-base-humble_container' is Up or Paused.
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
docker exec -it --env HOSTUSER=$USER pet-base-humble_container bash