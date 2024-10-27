#!/bin/bash
# This will bring up an Docker 'source' Image/Container
#   1) Docker 'Source' Docker Image/Container (out-of-the-box from OSRF) <- This ./Dockerfile
#   2) Docker 'Base' Image/Container (Customized ) 
#   3) Docker 'Overlay' Image/Container
#
# Launch out-of-the-box OSRF ROS2/Ubuntu Docker Image for RasperryPI(arm64)
#  - Enabeling access to host hardware, like I2C, GPIO and SPI from inside the Docker container.
#  - Enabeling access x11 gui from inside the Docker container.
#
# Expectations:
#  - Inside Image/Container - Reuse 'User ID' & 'Group ID' from Docker host inside Docker-host system.
#  - Run out-of-the-box Ubuntu/ROS2 image from osrf.
#  - All low-level hardware pass-through should be enabled for testing.
#  - To allow x11 gui access from inside the Docker container: 
#    Run the command $ xhost local:docker before connect to the DOcker Image/Container
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/humble(arm64v8)
#  - OS version:   Ubuntu 22.04/jammy(arm64v8)
#
# More info: 
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble
docker run \
    --interactive \
    --tty \
    --rm \
    --network=host \
    --privileged \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /proc/device-tree:/proc/device-tree:ro \
    --device /dev/gpiomem:rw \
    --device /dev/i2c-1:rw \
    --device /dev/spidev0.0:rw \
    --device /dev/spidev0.1:rw \
    --device /dev/vchiq:r \
    --user=$(id -u $USER):$(id -g $USER) \
    --workdir /home/$USER \
    --volume /home/$USER:/home/$USER \
    --volume /etc/group:/etc/group:ro \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/shadow:/etc/shadow:ro \
    --volume /etc/sudoers:/etc/sudoers:ro \
    --volume /etc/sudoers.d:/etc/sudoers.d:ro \
    kullken/ros2_arm64v8:pet-base-humble /bin/bash
