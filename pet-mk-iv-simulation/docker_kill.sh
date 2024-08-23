#!/bin/bash
# Stop and remove Docker-container
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series

# "noetic" = ROS1
# "focal"  = Ubuntu 20.04 

# More info: https://github.com/Pet-Series/pet_docker
# More info: https://hub.docker.com/repositories/kullken
# More info: https://hub.docker.com/repository/docker/kullken/ros1_amd64
docker container stop   pet-mk-iv-simulation_container 
docker container kill pet-mk-iv-simulation_container
docker container rm   pet-mk-iv-simulation_container 