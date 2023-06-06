#!/bin/bash
# Run docker image from https://hub.docker.com/repository/docker/kullken/ros1_amd64
docker run \
 -it \
 --rm \
 --network=host \
 --privileged \
 kullken/ros1_amd64:pet-mk-iv-simulation