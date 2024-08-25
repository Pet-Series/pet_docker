# Docker specifications supporting the Pet-Series of robots.
This repo hosts Dockerfiles and scaffolding for images in the Pet-Series oarganisation.
Docker specifications supporting Pet-Series and ROS1/ROS2 middleware.
* Docker images for ARM4 = Rasberry Pi running 64bit Ubuntu
* Docker images for AMD64/X86 = PC running 64bit Ubuntu

# GitHub Links
* https://github.com/Pet-Series

# Docker for Robot Operating System 2 (ROS2) - Onboard robot
  * **Target architecture:** ARM64 (aka."Rasberry Pi 3-4-5")
  * **Operating system:** Ubuntu
  * **Middleware:** Robot Operating System 2 (ROS2)
* https://hub.docker.com/repository/docker/kullken/ros2_arm64v8* 
  * Based on: https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=jazzy
  * Based on: https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble
  * Based on: https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=galactic

# Docker for Robot Operating System 2 (ROS2) - Offboard
  * **Target architecture:** AMD64/x86 (aka."PC", aka. "Workstation")
  * **Operating system:** Ubuntu
  * **Middleware:** Robot Operating System 2 (ROS2)
    * Developing & Running ROS2 applications
    * Running simulation in ROS2
    * Developing & uploading firmware to microcontrollers using micro-ROS
* https://hub.docker.com/r/osrf/ros/tags?name=jazzy
* https://hub.docker.com/repository/docker/kullken/ros2_amd64

# DockerHub links for amd64 (aka "PC", aka. "Workstation")
 * **Target architecture:**  AMD64/x86 (aka."PC", aka. "Workstation")
  * **Operating system:** Ubuntu
  * **Middleware:** Robot Operating System 1 (ROS1)
    * Developing & Running ROS1 applications
    * Running simulation in     ROS1
* https://hub.docker.com/r/osrf/ros/tags?page=1&name=noetic
* https://hub.docker.com/repository/docker/kullken/ros1_amd64

