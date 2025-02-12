#!/bin/bash
# Launch custom Docker 'Base' Image for Raspberry PI(arm64)
#
# Expectations:
#  - Run our own custom Docker 'Base' Image.
#  - Inside the Docker Container, the user ID is 2000:2000 'pet'
#  - Enabling access to host low-level-hardware, like I2C, GPIO and SPI from inside the Docker container.
#  - All low-level libraries for hardware access on Raspberry Pi should be installed
#  - Enabling access x11 gui from inside the Docker container.
#  - Entrypoint CMD = /bin/bash 
#
# Prerequisite - On docker host:
#       I)  To enable GUI/X11 applications inside the container
#           That '$ xhost local:docker' is started before the container is started.
#
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
# - ROS2 version: ROS2/jazzy(arm64v8)
# - OS version:   Ubuntu 24.04/noble(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=jazzy

ROS_DISTRO="jazzy"
docker run \
    --interactive \
    --tty \
    --rm \
    --network=host \
    --privileged \
    --annotation="Annotation to the container (passed through to the OCI runtime)" \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume /etc/localtime:/etc/localtime:ro \
    --env DISPLAY=$DISPLAY \
    --env HOSTUSER=$USER \
    --device /dev/gpiomem:rw \
    --device /dev/i2c-1:rw \
    --device /dev/spidev0.0:rw \
    --device /dev/spidev0.1:rw \
    --device /dev/vchiq:r \
    --name 'pet-base-'$ROS_DISTRO'_container' \
    kullken/ros2_arm64v8:pet-base-$ROS_DISTRO