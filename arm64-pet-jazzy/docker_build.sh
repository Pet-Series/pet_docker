#!/bin/bash
# Build Dockerfile in the same directory
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#
# "jazzy" = ROS2
# "noble"  = Ubuntu 24.04
#
# More info: 
#    - https://github.com/Pet-Series/pet_docker
#    - https://hub.docker.com/repositories/kullken
#    - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#    - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=jazzy
#
# docker build --tag kullken/ros2_arm64v8:pet-base-jazzy . --no-cache
docker build --tag kullken/ros2_arm64v8:pet-base-jazzy .