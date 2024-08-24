#!/bin/bash
# Push up a local Docker Image to DockerHub repository.
#
# Prerequisite:
#   $ docker login -u "kullken" -p "@@@@@@@@" docker.io
#
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#
# "humble"= ROS2
# "focal"  = Ubuntu 20.04 
#
# More info: 
#    - https://github.com/Pet-Series/pet_docker
#    - https://hub.docker.com/repositories/kullken
#    - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#    - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble
docker push kullken/ros2_arm64v8:pet-mk-viii-runtime