#!/bin/bash
# Build my own custom Docker 'Base' Image.
# Using the ./Dockerfile in the same directory.
#   Level 1) Docker 'Source' Image:
#            1.1 FROM ubuntu:noble
#            1.2 FROM osrf/ros:jazzy-desktop-full
#            1.3 => osrf/ros:jazzy-desktop-full-noble
#   Level 2) This custom Docker 'Base' Image:
#            2.1 FROM osrf/ros:jazzy-desktop-full-noble
#            2.0 => kullken/ros2_amd64:jazzy-full
#   Level 3) Nest step is the custom Docker 'Overlay' Image
#            3.1 kullken/ros2_amd64:jazzy-full
#            3.2 => n/a 
#
# "kullken" = DockerWeb User
# "ros2_amd64" = DockerWeb Repository
# "jazzy-full" = DockerWeb Tag
#
# Prerequisite - On docker host: 
#   I) Raspberry Pi(arm64v8) with Ubuntu & Docker installed.  
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/Jazzy Jalisco(amd64/PC)
#  - OS version:   Ubuntu 24.04/noble(amd64/PC)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_amd64
#  - https://hub.docker.com/repository/docker/kullken/ros2_amd64/tags?name=jazzy
#  - https://hub.docker.com/r/osrf/ros/tags?page=1&name=jazzy

ROS_DISTRO=jazzy
docker pull osrf/ros:${ROS_DISTRO}-desktop
docker pull osrf/ros:${ROS_DISTRO}-desktop-full
docker pull osrf/ros:${ROS_DISTRO}-desktop-full-noble  # Docker 'Source' Image
docker build \
    --tag kullken/ros2_amd64:$ROS_DISTRO-full \
    --annotation "index,manifest,manifest-descriptor:note=Custom Ubuntu/ROS2 $ROS_DISTRO Image for my off-board PC..." \
    .
#    --no-cache \
#   .