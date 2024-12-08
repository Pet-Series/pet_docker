#!/bin/bash
# Launch out-of-the-box OSRF ROS2/Ubuntu Docker Image for RasperryPI(arm64)
#  - Enabeling access to host hardware, like I2C, GPIO and SPI from inside the Docker container.
#  - Enabeling access x11 gui from inside the Docker container.
#
# Expectations:
#  - Inside Image/Container: Run as user 'ubuntu' 1000:1000
#  - Run out-of-the-box Ubuntu/ROS2 image from osrf.
#  - All low-level hardware pass-through should be enabled for testing.
#  - To allow x11 gui access from inside the Docker container: Run the command
#    $ xhost local:docker
#
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
#  - https://hub.docker.com/_/ros
#  - https://index.ros.org/p/ros1_bridge/github-ros2-ros1_bridge/
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=galactic
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=noetic
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