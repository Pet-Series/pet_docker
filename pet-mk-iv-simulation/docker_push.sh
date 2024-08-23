#!/bin/bash
# Push a Docker Image to DockerHub repository.
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series

# "noetic" = ROS1
# "focal"  = Ubuntu 20.04 

# docker login -u "kullken" -p "@@@@@@@@" docker.io
docker push kullken/ros1_amd64:pet-mk-iv-simulation