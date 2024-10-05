![License MIT](https://img.shields.io/github/license/Pet-Series/pet_docker?color=blue&style=plastic)
![ROS version](https://img.shields.io/badge/ROS1-Noetic-brightgreen?style=plastic)
![ROS version](https://img.shields.io/badge/ROS2-Galatic-brightgreen?style=plastic)
![Ubuntu version](https://img.shields.io/badge/Ubuntu-22.04.6-green?style=plastic)

# README: /pet_docker/arm64-galactic

ROS2-docker repository in the https://github.com/Pet-Series Git-Organizations.</br>

- FROM ```osrf/ros:galactic-ros1-bridge-focal``` (arm64/Raspberry Pi 4/5)
    - Ubuntu 20.04.6 LTS aarch64 (aka. "Focal Fossa")
    - ROS2 Galatic Geoclone (deprectaded/no longer supported after November 2022)
      - https://docs.ros.org/en/galactic/
    - ROS1 Noetic Ninjemys
      - https://wiki.ros.org/noetic
    - ROS1 bridge to ROS1
      - https://github.com/ros2/ros1_bridge
      - https://github.com/ros2/ros1_bridge/blob/master/doc/index.rst
      - https://github.com/ros2/common_interfaces

# Base layer for ROS2/galactic and ROS1/Noetic running on Raspberry Pi 4/5
- Aimed to run on my ROS2 based Dashboard(Remote Controller), Pet-Mk.VIII|https://github.com/Pet-Series/Pet-Mk-VIII.
- Main reason to create a Docker environment based on "old" ROS2/galactic is..
  1. ROS2/galactic is the last ROS2 version that has a native ros-bridge (to ROS1/Noetic) built in.
  1. I have an old robot, Pet-Mk.IV, running ROS1 Noetic(Simulation)/Melodic(IRL)...</br>
    ...which I wish to control from my ROS2-based Dashboard (remote control), Pet-Mk.VIII.
    

# Note to self..
1. [x] Current branch: https://github.com/Pet-Series/pet_docker/tree/New-Galatic%26ROS-bridge-to-Noetic-for(ARM64)
1. [ ] Test https://github.com/Pet-Series/Pet-Mk-VIII that was developed for ROS2 Humble</br>
    Will the ROS2 Humble package be backward compatibale with ROS2 Galatic?
1. [ ] Consistent Image and container naming.