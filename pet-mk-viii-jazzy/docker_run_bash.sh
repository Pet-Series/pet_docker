#!/bin/bash
# Run Custom Docker 'Overlay' Image + Create Docker Container on a Raspberry PI(arm64)
#
# Expectations:
#  - Run our own custom Docker 'Overlay' Image.
#  - Inside the Docker Container, the user ID is 2000:2000 'pet'
#  - Enabling access to RPi host hardware, like I2C, GPIO and SPI from inside the Docker 'Overlay' container.
#  - All low-level libraries for hardware access on Raspberry Pi should be installed
#  - Enabling access x11 gui from inside the Docker container.
#  - Entrypoint CMD = /bin/bash
#
# Prerequisite - On docker host:
#       I)  To enable GUI/X11 applications inside the container
#           That '$ xhost local:docker' is started before the container is started.
#       II) On docker host must $ git clone https://github.com/Pet-Series/Pet-Mk-VIII.git => /home/pet/ws_ros2-jazzy/src
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

ROS_DISTRO=jazzy
HOST_WS=$HOME/ws_ros2_$ROS_DISTRO
CONTAINER_WS=/home/pet/ws_ros2
docker run \
    -it \
    --network host \
    --privileged \
    --volume $HOST_WS:$CONTAINER_WS \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --volume /etc/localtime:/etc/localtime:ro \
    --env DISPLAY=$DISPLAY \
    --env HOSTUSER=$USER \
    --name 'pet-mk-viii-runtime-'$ROS_DISTRO'_container' \
    --device /dev/gpiomem:rw \
    --device /dev/i2c-1:rw \
    --device /dev/spidev0.0:rw \
    --device /dev/spidev0.1:rw \
    --device /dev/vchiq:r \
    kullken/ros2_arm64v8:pet-mk-viii-$ROS_DISTRO /bin/bash