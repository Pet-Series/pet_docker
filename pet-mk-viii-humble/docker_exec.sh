#!/bin/bash
# Start bash in existing container (Status Up/Paused).
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series

# "humble" = ROS2 22.04
# "noble" = Ubuntu 22.04

# More info: https://github.com/Pet-Series/pet_docker
# More info: https://hub.docker.com/repositories/kullken
docker exec -it --env HOSTUSER=$USER pet-base-humble_container bash