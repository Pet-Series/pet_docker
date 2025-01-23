#!/bin/bash
# Push up a local Docker 'Overlay' Image to DockerHub repository.
#
# Prerequisite:
#   $ docker login -u "kullken" -p "@@@@@@@@" docker.io
#   - ...existing local Docker 'Overlay' Image kullken/ros2_arm64v8:pet-mk-viii-jazzy
#
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

docker push kullken/ros2_arm64v8:pet-mk-viii-jazzy   # Docker 'Overlay' Image