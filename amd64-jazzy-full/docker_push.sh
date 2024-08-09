#!/bin/bash
# Push local Docker Image to DockerHub repository.
# 
# Prerequisite:
#   $ docker login -u "kullken" -p "@@@@@@@@" docker.io
#
# More info: https://hub.docker.com/repositories/kullken
docker push kullken/ros2_amd64:jazzy-full