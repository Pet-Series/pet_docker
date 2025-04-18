# This is an ./Dockerfile for my custom Docker 'Overlay' Image
#   Level 0) Docker 'Source' Image   = arm64v8/ros:humble-ros-base-jammy
#   Level 1) Docker 'Base' Image     = kullken/ros2_arm64v8:pet-base-humble 
#   Level 3) Docker 'Overlay' Image  = kullken/ros2_arm64v8:pet-mk-viii-humble <-This ./Dockerfile
# 
# Description:
#   Target hardware platform: Pet-Mk.VIII(aka. "Dashboard") running using a Raspberry PI[arm64v8].
#   Running Ubuntu with Robot Operating System 2(ROS2)
#   Interact with local RPi hardware as joystick, potentiometers, indicator leds... via GPIO, I2C and SPI.
#
# Prerequisite - On docker host before building/starting Docker Image/Container:
#   a)  Raspberry Pi3..5 running Ubuntu and Docker installed.
#   b)  That '$ xhost local:docker' is started before the container is started. 
#       To enable GUI/X11 applications inside the container
#   c) '$ git clone https://github.com/Pet-Series/Pet-Mk-VIII.git" => /home/pet/ws_ros2-jazzy/src
#
# Build Docker Image and launch Docker Container with:
#  $ docker compose up --detach 
#
# Connect terminal Docker Container with:
#  $ xhost local:docker
#  $ ./docker_exec.sh
#
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/humble(arm64v8)
#  - OS version:   Ubuntu 22.04/jammy(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble

FROM  kullken/ros2_arm64v8:pet-base-humble 
ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Pet-Mk.VIII[humble]"

LABEL description="Custom ROS2 Humble Overlay Docker Image for Pet-Mk.VIII (aka. 'Dashboard')"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.1"
SHELL ["/bin/bash", "-c"]

# Add custom shell-prompt for this Docker Image to ~/.bashrc
USER ${DOCKERUSER}
RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> /home/pet/.bashrc 

# Recreate/Pre-load the '.bash_history' in the bash-terminal
USER root
WORKDIR ${HOMEDIR}
COPY .bash_history ${HOMEDIR}/.bash_history
RUN chmod 600 ${HOMEDIR}/.bash_history &&\
    chown ${DOCKERUSER} ${HOMEDIR}/.bash_history &&\
    chgrp ${DOCKERUSER} ${HOMEDIR}/.bash_history 

# Put the Docker 'ros_entrypoint.sh' bash script in place...
COPY ./ros_entrypoint.sh ${HOMEDIR}/ros_entrypoint.sh 
USER root
RUN chmod +x ${HOMEDIR}/ros_entrypoint.sh && \
    chown ${DOCKERUSER} ${HOMEDIR}/ros_entrypoint.sh &&\
    chgrp ${DOCKERUSER} ${HOMEDIR}/ros_entrypoint.sh
    
# Setup exit conditions
# ENTRYPOINT instruction is used to configure the executables that will always run after the container is initiated (not by '$ docker exec')
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
ENTRYPOINT ["/home/pet/ros_entrypoint.sh"]
CMD ["/bin/bash"]
# CMD ["ros2", "launch", "pet_mk_viii", "pet-mk-viii-bringup.launch.py"]
