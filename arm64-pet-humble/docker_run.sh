#!/bin/bash
# Run docker image from https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
# Entrypoint CMD = /bin/bash
#
# Prerequisite - On docker host: 
#       I)  That '$ xhost local:docker' is started before the container is started. To enable GUI/X11 applications inside the container
#       II) Docker host must clone https://github.com/Pet-Series/Pet-Mk-VIII.git => /home/pet/ws_ros2/src
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/humble(arm64v8)
#  - OS version:   Ubuntu 22.04/jammy(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble

docker run \
    --interactive \
    --tty \
    --rm \
    --network host \
    --privileged \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /proc/device-tree:/proc/device-tree:ro \
    --env DISPLAY=${DISPLAY} \
    --env HOSTUSER=$USER \
    --device /dev/gpiomem:rw \
    --device /dev/i2c-1:rw \
    --device /dev/spidev0.0:rw \
    --device /dev/spidev0.1:rw \
    --device /dev/vchiq:r \
    --name pet-base-humble_container \
    kullken/ros2_arm64v8:pet-base-humble /bin/bash