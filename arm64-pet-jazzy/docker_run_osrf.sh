#!/bin/bash
# Launch out-of-the-box OSRF ROS2/Ubuntu Docker 'Source' Image for Raspberry PI(arm64)
#  - Enabling access to host hardware, like I2C, GPIO and SPI from inside the Docker container.
#  - Enabling access x11 gui from inside the Docker container.
#
# Expectations:
#  - Inside Image 'Source' Container: Run as user 'ubuntu' 1000:1000
#  - Run out-of-the-box Ubuntu/ROS2 image from OSRF.
#  - All low-level hardware pass-through should be enabled for testing.
#  - To allow x11 gui access from inside the Docker container: Run the command
#    $ xhost local:docker
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
#  - https://hub.docker.com/r/arm64v8/ros/tags
#  - https://hub.docker.com/r/arm64v8/ros/tags?name=jazzy

docker run \
    --interactive \
    --tty \
    --rm \
    --network=host \
    --privileged \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --env DISPLAY=$DISPLAY \
    --device=/dev/gpiomem:rw \
    --device=/dev/i2c-1:rw \
    --device=/dev/spidev0.0:rw  \
    --device=/dev/spidev0.1:rw \
    --device=/dev/vchiq:r \
    arm64v8/ros:jazzy-ros-base-noble