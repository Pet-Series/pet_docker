#!/bin/bash
# Build Image from ./Dockerfile (in the same directory)
# "kullken" = DockerWeb User
# "ros2_amd64" = DockerWeb Repository
# "jazzy-full" = DockerWeb Tag
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#----------------------
#
# "jazzy" = ROS2 24.04
# "noble" = Ubuntu 24.04
# More info: https://hub.docker.com/repositories/kullken
docker build --tag kullken/ros2_amd64:jazzy-full .