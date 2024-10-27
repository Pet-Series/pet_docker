# Dockerfile for Pet-Mk.VIII (aka. "Dashboard"). Raspberry PI[ARM64] interac with local hardware as joystick, potentiometers, indicator leds...
#
# Prerequisite - On docker host before starting Docker Image/Container: 
#       I)  That '$ xhost local:docker' is started before the container is started. To enable GUI/X11 applications inside the container
#       II) Docker host must clone https://github.com/Pet-Series/Pet-Mk-VIII.git => /home/pet/ws_ros2-galactic/src
#
# Build Docker image with:
#----------------------
# $ docker build --tag kullken/ros2_arm64v8:pet-mk-viii-runtime-galactic .
#----------------------
#
# Launch Docker Image with:
#----------------------
# docker run \
#   -it \
#   --detach \
#   --network=host \
#   --privileged \
#   --volume /home/pi/ws_ros2:/home/pet/ws_ros2 \
#   --volume /tmp/.X11-unix:/tmp/.X11-unix \
#   --env DISPLAY=${DISPLAY} \
#   --env HOSTUSER=$USER \
#   --name pet-mk-viii-galactic_container \
#   --device=/dev/gpiomem:rw \
#   --device=/dev/mem:rw \
#   --device=/dev/i2c-1:rw \
#   --device=/dev/spidev0.0:rw  \
#   --device=/dev/spidev0.1:rw \
#   --device=/dev/vchiq:r \
#   kullken/ros2_arm64v8:pet-mk-viii-galactic /bin/bash
#----------------------
# Prerequisit: Docker host must clone https://github.com/Pet-Series/Pet-Mk-VIII.git => /home/pet/ws_ros2/src
#
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#
# "galactic" = ROS2
# "focal"  = Ubuntu 20.04 
#
# More info: 
#    - https://github.com/Pet-Series/pet_docker
#    - https://hub.docker.com/repositories/kullken
#    - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#    - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=galactic

FROM  kullken/ros2_arm64v8:pet-base-galactic
ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Pet-Mk.VIII[galactic]"

LABEL description="ROS2 galactic image for Pet-Mk.VIII (aka. 'Dashboard') - Launch all basic ROS2 nodes"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.0"

# Recreate/Pre-load the '.bash_history' for commands
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
COPY .bash_history ${HOMEDIR}/.bash_history
USER root
RUN  chmod 600 ${HOMEDIR}/.bash_history && chown ${DOCKERUSER} ${HOMEDIR}/.bash_history  && sudo chgrp ${DOCKERUSER} ${HOMEDIR}/.bash_history 

# Setup exit condtions
USER ${DOCKERUSER}
CMD ["ros2", "launch", "pet_mk_viii", "pet-mk-viii-bringup.launch.py"]
# ENTRYPOINT ["${HOMEDIR}/ros-entrypoint.sh"]