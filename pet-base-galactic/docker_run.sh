#!/bin/bash
# Run docker image from https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
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
    -it \
    --network host \
    --privileged \
    --volume /home/pi/ws_ros2-galactic:/home/pet/ws_ros2 \
    --volume /tmp/.X11-unix:/tmp/.X11-unix \
    --volume="/etc/localtime:/etc/localtime:ro" \
    --env DISPLAY=${DISPLAY} \
    --env HOSTUSER=$USER \
    --name pet-base-galactic_container \
    --device /dev/gpiomem:/dev/gpiomem \
    --device /dev/i2c-1:/dev/i2c-1 \
    --device /dev/spidev0.0:/dev/spidev0.0 \
    --device /dev/spidev0.1:/dev/spidev0.1 \
    kullken/ros2_arm64v8:pet-base-galactic