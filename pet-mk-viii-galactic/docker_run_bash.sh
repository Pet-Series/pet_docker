#!/bin/bash
# Run Docker Image and create Docker Container on a Raspberry PI
# Entrypoint CMD = /bin/bash
#
# Prerequisite - On docker host: 
#       I)  That '$ xhost local:docker' is started before the container is started. To enable GUI/X11 applications inside the container
#       II) Docker host must clone https://github.com/Pet-Series/Pet-Mk-VIII.git => /home/pet/ws_ros2-galactic/src
#
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#
# "galactic" = ROS2
# "focal"  = Ubuntu 20.04 
#
# More info: 
#    - https://github.com/Pet-Series/pet_docker
#    - https://hub.docker.com/repositories/kullken
#    - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#    - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=galactic
docker run \
    --interactive \
    --tty \
    --network host \
    --privileged \
    --volume /home/pi/ws_ros2:/home/pet/ws_ros2:rw \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --env DISPLAY=${DISPLAY} \
    --env HOSTUSER=$USER \
    --name pet-mk-viii-runtime-galactic_container \
    --device /dev/gpiomem:/dev/gpiomem \
    --device /dev/i2c-1:/dev/i2c-1 \
    --device /dev/spidev0.0:/dev/spidev0.0 \
    --device /dev/spidev0.1:/dev/spidev0.1 \
    --device=/dev/vchiq:r \
    kullken/ros2_arm64v8:pet-mk-viii-galactic /bin/bash