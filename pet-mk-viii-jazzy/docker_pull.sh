#!/bin/bash
# Download docker images from Docker Hub from https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/jazzy(arm64v8)
#  - OS version:   Ubuntu 24.04/noble(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=jazzy
docker pull kullken/ros2_arm64v8:pet-base-jazzy
docker pull kullken/ros2_arm64v8:pet-mk-viii-jazzy