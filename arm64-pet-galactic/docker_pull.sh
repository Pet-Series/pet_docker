#!/bin/bash
# Download the Docker Image to your Raspberry PI 3..5 from Docker Hub
#----------------------
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/galactic(arm64v8)
#  - ROS1 version: ROS1/noetic(arm64v8)
#  - OS version:   Ubuntu 20.04/focal(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=galactic
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=noetic

docker pull arm64v8/ros:galactic-ros1-bridge-focal
docker pull kullken/ros2_arm64v8:pet-base-galactic