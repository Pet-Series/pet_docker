#!/bin/bash
# Launch out-of-the-box OSRF ROS2/Ubuntu Docker 'Source' Image for Raspberry PI(arm64)
#  - Enabling access to host hardware, like I2C, GPIO and SPI from inside the Docker container.
#  - Enabling access x11 gui from inside the Docker container.
#
# Expectations:
#  - Reuse User ID & Group ID from Docker-host system.
#  - Run out-of-the-box Docker Ubuntu/ROS2 'Source' Image.
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
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/r/arm64v8/ros/tags
#  - https://hub.docker.com/r/arm64v8/ros/tags?name=jazzy

docker run \
    --interactive \
    --tty \
    --rm \
    --network=host \
    --privileged \
    --user=$(id -u $USER):$(id -g $USER) \
    --workdir="/home/$USER" \
    --volume="/home/$USER:/home/$USER" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers:/etc/sudoers:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    arm64v8/ros:jazzy-ros-base-noble
