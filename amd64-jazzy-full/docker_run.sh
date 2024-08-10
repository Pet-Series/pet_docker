#!/bin/bash
# Run docker image from https://hub.docker.com/repositories/kullken
 docker run \
  -it \
  --name jazzy-full-container \
  --env DISPLAY=$DISPLAY \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="/etc/localtime:/etc/localtime:ro" \
  --network=host \
  kullken/ros2_amd64:jazzy-full