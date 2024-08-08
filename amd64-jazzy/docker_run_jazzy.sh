#!/bin/bash
# Run Image and create Container (AMD64 CPU Architecture)
# - ROS Version: ROS2 2024    LTS(AMD64) aka."Jazzy"
# - OS version : Ubuntu 24.04 LTS(AMD64) aka."noble"
#  - Source Image = osrf/ros:jazzy-desktop-full
#  - Target Container = jazzy-full-container
#  - Mount your docker-host /home/{$USER}
#  - Run your docker-host ~/bashrc
#
# docker exec -it jazzy-full-container bash
# docker container pause jazzy-full-container
# docker container stop jazzy-full-container
# docker container restart jazzy-full-container
# docker container kill jazzy-full-container
# docker container rm jazzy-full-container
docker run -it \
 --name jazzy-full-container \
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
 --volume="/etc/localtime:/etc/localtime:ro" \
osrf/ros:jazzy-desktop-full