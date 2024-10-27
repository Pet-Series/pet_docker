#!/bin/bash
# Build Base Image layer based on ./Dockerfile in the same directory
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
# docker build --tag kullken/ros2_arm64v8:pet-base-humble .
docker build --tag kullken/ros2_arm64v8:pet-base-humble  --no-cache .