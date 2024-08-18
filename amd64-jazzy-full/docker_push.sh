#!/bin/bash
# Push local Docker Image to DockerHub repository.
# 
# Prerequisite:
#   $ docker login -u "kullken" -p "@@@@@@@@" docker.io
#
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series

# "jazzy" = ROS2 24.04
# "noble" = Ubuntu 24.04

# More info: https://github.com/Pet-Series/pet_docker
# More info: https://hub.docker.com/repositories/kullken
docker push kullken/ros2_amd64:jazzy-full