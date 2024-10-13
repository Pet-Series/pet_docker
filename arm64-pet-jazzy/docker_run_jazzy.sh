#!/bin/bash
# Docker Run based on ROS2 Humble (ARM64v8 CPU Architecture)
#
# Links to source/original...
# https://hub.docker.com/r/arm64v8/ros/tags
# https://hub.docker.com/r/arm64v8/ros/tags?name=jazzy
docker run -it \
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
