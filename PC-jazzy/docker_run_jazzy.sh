#!/bin/bash
# Docker Run based on ROS2 Jazzy (AMD64 CPU Architecture)

docker run -it \
 --env DISPLAY=$DISPLAY \
 --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
 --network=host \
 --user=$(id -u $USER):$(id -g $USER) \
 --workdir="/home/$USER" \
 --volume="/home/$USER:/home/$USER" \
 --volume="/etc/group:/etc/group:ro" \
 --volume="/etc/passwd:/etc/passwd:ro" \
 --volume="/etc/shadow:/etc/shadow:ro" \
 --volume="/etc/sudoers:/etc/sudoers:ro" \
 --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
osrf/ros:jazzy-desktop-full
