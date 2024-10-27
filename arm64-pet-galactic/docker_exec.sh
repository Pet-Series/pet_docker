#!/bin/bash
# Start new bash/terminal in existing custom Docker Container.
#
# Prerequisite - On docker host: 
#   I) Raspberry Pi(arm64v8) with Ubuntu & Docker installed.
#  II) Docker Container with name 'pet-base-galactic_container' is Up or Paused.
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/Galactic Geoclone(arm64v8)    <- No longer supported 2022-...
#  - ROS1 version: ROS1/Noetic Ninjemys(arm64v8)      <- No longer supported 2019-...
#  - OS version:   Ubuntu 20.04 LTS/Focal Fossa(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/_/ros
#  - https://index.ros.org/p/ros1_bridge/github-ros2-ros1_bridge/
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=galactic
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=noetic
docker exec -it pet-base-galactic_container bash