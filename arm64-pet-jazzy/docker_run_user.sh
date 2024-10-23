#!/bin/bash
# Docker Run based on ROS2 (ARM64v8 CPU Architecture)
#
# Expectations:
#  - Reuse User ID & Group ID from Docker-host system.
#  - Run out-of-the-box Ubuntu/ROS2 image.
#  - To allow x11 gui access from inside the Docker container: Run the command
#    $ xhost local:docker
#
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
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
    --user=$(id -u $USER):$(id -g $USER) \
    --workdir="/home/$USER" \
    --volume="/home/$USER:/home/$USER" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers:/etc/sudoers:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    arm64v8/ros:jazzy-ros-base-noble
