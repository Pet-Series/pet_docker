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
#  - ROS2 version: ROS2/Galactic Geoclone(arm64v8)    <- No longer supported 2022-...
#  - ROS1 version: ROS1/Noetic Ninjemys(arm64v8)      <- No longer supported 2019-...
#  - OS version:   Ubuntu 20.04 LTS/Focal Fossa(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
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
    --volume /home/pi/ws_ros2-galactic:/home/pet/ws_ros2 \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --env DISPLAY=${DISPLAY} \
    --env HOSTUSER=$USER \
    --device=/dev/gpiomem:rw \
    --device=/dev/i2c-1:rw \
    --device=/dev/spidev0.0:rw  \
    --device=/dev/spidev0.1:rw \
    --device=/dev/vchiq:r \
    --name pet-base-galactic_container \
    kullken/ros2_arm64v8:pet-base-galactic