#!/bin/bash
# Run docker image from https://hub.docker.com/repository/docker/kullken/ros1_amd64

# Connect to, an running, container using shell/bash by: 
# $ docker exec -it pet-mk-iv-simulation_container bash
docker run \
 -it \
 --rm \
 --network=host \
 --privileged \
 --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
 --env DISPLAY=${DISPLAY} \
 --name pet-mk-iv-simulation_container \
 kullken/ros1_amd64:pet-mk-iv-simulation