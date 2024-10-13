#!/bin/bash
# Start bash in existing container (Status Up/Paused).
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#
# "humble" = ROS2
# "jammy"  = Ubuntu 22.04 
#
# More info: 
#    - https://github.com/Pet-Series/pet_docker
#    - https://hub.docker.com/repositories/kullken
#    - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#    - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble
#
docker exec -it --env HOSTUSER=$USER pet-base-humble_container bash