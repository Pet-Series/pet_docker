#!/bin/bash
# Build Docker 'Overlay' Image from ./Dockerfile  in the same directory.
#
# Prerequisite - On docker host: 
#   I) Raspberry Pi(arm64v8) with Ubuntu & Docker installed.
#  II) This build is on top of Docker base image kullken/ros2_arm64v8:pet-base-jazzy
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
#
# docker build --tag kullken/ros2_arm64v8:pet-mk-viii-jazzy --no-cache .
# docker build --tag kullken/ros2_arm64v8:pet-mk-viii-jazzy --progress=plain .

docker build --tag kullken/ros2_arm64v8:pet-mk-viii-jazzy --no-cache .