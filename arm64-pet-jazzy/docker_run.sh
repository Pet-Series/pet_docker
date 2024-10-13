#!/bin/bash
# Run docker image from https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
docker run \
    -it \
    --rm \
    --network=host \
    --privileged \
    --annotation="Annotation to the container (passed through to the OCI runtime)" \
    --env VAR2=value2 \
    --device=/dev/gpiomem:rw \
    --device=/dev/mem:rw \
    --device=/dev/i2c-1:rw \
    --device=/dev/spidev0.0:rw  \
    --device=/dev/spidev0.1:rw \
    --device=/dev/vchiq:r \
    arm64v8/ros:jazzy-ros-base-noble
#   kullken/ros2_arm64v8:pet-base-jazzy