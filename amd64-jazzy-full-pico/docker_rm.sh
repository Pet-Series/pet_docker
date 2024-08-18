#!/bin/bash
# Remove existing container (Prereq: Status=Exited/Stoped)
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series

# "jazzy" = ROS2 24.04
# "noble" = Ubuntu 24.04

# More info: https://github.com/Pet-Series/pet_docker
# More info: https://hub.docker.com/repositories/kullken
docker container rm jazzy-full-pico-container