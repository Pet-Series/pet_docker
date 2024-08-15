#!/bin/bash
# Run docker image from https://hub.docker.com/repositories/kullken
 docker run \
  -it \
  --privileged \
  --name jazzy-full-pico-container \
  --env DISPLAY=$DISPLAY \
  --env HOSTUSER=$USER \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="/etc/localtime:/etc/localtime:ro" \
  --volume="/media:/media:rw" \
  --volume="/home/$USER/ws_ros2:/home/ubuntu/ws_ros2:rw" \
  --network=host \
  kullken/ros2_amd64:jazzy-full-pico