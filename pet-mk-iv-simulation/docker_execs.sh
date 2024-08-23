#!/bin/bash
# Start bash in existing container (Status Up/Paused).
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series

# "noetic" = ROS1
# "focal"  = Ubuntu 20.04 

# More info: https://github.com/Pet-Series/pet_docker
# More info: https://hub.docker.com/repositories/kullken
# More info: https://hub.docker.com/repository/docker/kullken/ros1_amd64
docker exec -it pet-mk-iv-simulation_container bash -c "source /home/pet/ws_ros1/devel/setup.bash && roslaunch pet_mk_iv_simulation pet_play_yard-02.launch"
docker exec -it pet-mk-iv-simulation_container bash -c "source /home/pet/ws_ros1/devel/setup.bash && roslaunch pet_mk_iv_simulation spawn_pet_mk_iv.launch"
docker exec -it pet-mk-iv-simulation_container bash -c "source /home/pet/ws_ros1/devel/setup.bash && roslaunch pet_mk_iv_description rviz.launch"
docker exec -it pet-mk-iv-simulation_container bash -c "source /home/pet/ws_ros1/devel/setup.bash && rosrun pet_mk_iv_mission_control testrun_01_avoid-wall-line-stop.py"