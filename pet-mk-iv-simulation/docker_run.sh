#!/bin/bash
# Run docker image from https://hub.docker.com/repository/docker/kullken/ros1_amd64
#
# Connect to, an running, container using shell/bash by: 
#   $ docker exec -it pet-mk-iv-simulation_container bash
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series

# "noetic" = ROS1
# "focal"  = Ubuntu 20.04

# More info: https://github.com/Pet-Series/pet_docker
# More info: https://hub.docker.com/repositories/kullken
xhost local:docker
docker run \
 -it \
 --detach \
 --network=host \
 --privileged \
 --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
 --env DISPLAY=${DISPLAY} \
 --name pet-mk-iv-simulation_container \
 kullken/ros1_amd64:pet-mk-iv-simulation