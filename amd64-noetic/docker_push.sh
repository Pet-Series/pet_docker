#!/bin/bash
# Push local Docker Image to DockerHub repository.
# 
# Prerequisite:
#   $ docker login -u "kullken" -p "@@@@@@@@" docker.io
#
# More info: https://hub.docker.com/repositories/kullken
#            https://github.com/Pet-Series/pet_docker/tree/main/amd64-noetic
docker push kullken/ros1_amd64:noetic-full