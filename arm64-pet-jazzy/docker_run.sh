#!/bin/bash
# Run custom ROS2/Ubuntu Docker Image&Container for RasperryPI(arm64v8 CPU Architecture)
#  - Enabeling access to host hardware, like I2C, GPIO and SPI from inside the Docker container.
#  - Enabeling access x11 gui from inside the Docker container.
#
# Expectations:
#   - Run our own custom Ubuntu/ROS2 image.
#   - Inside the Docker Container, the user ID is 1000:1000 'pet'
#   - To allow x11 gui access from inside the Docker container: Run the command
#     $ xhost local:docker
#   - All low-level libraries for hardware access on Raspebbry Pi should be installed
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
# - ROS2 version: ROS2/jazzy(arm64v8)
# - OS version:   Ubuntu 24.04/noble(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=jazzy

docker run \
    --interactive \
    --tty \
    --rm \
    --network=host \
    --privileged \
    --annotation="Annotation to the container (passed through to the OCI runtime)" \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --env DISPLAY=$DISPLAY \
    --env HOSTUSER=$USER \
    --device=/dev/gpiomem:rw \
    --device=/dev/i2c-1:rw \
    --device=/dev/spidev0.0:rw  \
    --device=/dev/spidev0.1:rw \
    --device=/dev/vchiq:r \
    --name pet-base-jazzy_container \
    kullken/ros2_arm64v8:pet-base-jazzy