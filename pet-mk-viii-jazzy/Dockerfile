# Overlay Dockerfile:
#   Hardware platform: Pet-Mk.VIII (aka. "Dashboard") running a Raspberry PI[ARM64].
#   Interac with local hardware as joystick, potentiometers, indicator leds... via GPIO, I2C and SPI.
#
# Prerequisite - On docker host before starting Docker Image/Container: 
#       I)  That '$ xhost local:docker' is started before the container is started. 
#           To enable GUI/X11 applications inside the container
#       II) '$ git clone https://github.com/Pet-Series/Pet-Mk-VIII.git" => /home/pet/ws_ros2-jazzy/src
#
# Build Docker image with:
#  $ docker build --tag kullken/ros2_arm64v8:pet-mk-viii-jazzy .
#
# Launch Docker Image with:
#  $ docker run \
#     -it \
#     --detach \
#     --network=host \
#     --privileged \
#     --volume /home/pi/ws_ros2:/home/pet/ws_ros2:rw \
#     --volume /tmp/.X11-unix:/tmp/.X11-unix:r \
#     --env DISPLAY=${DISPLAY} \
#     --env HOSTUSER=$USER \
#     --name pet-mk-viii-jazzy_container \
#     --device=/dev/gpiomem:rw \
#     --device=/dev/mem:rw \
#     --device=/dev/i2c-1:rw \
#     --device=/dev/spidev0.0:rw \
#     --device=/dev/spidev0.1:rw \
#     --device=/dev/vchiq:r \
#     kullken/ros2_arm64v8:pet-mk-viii-jazzy /bin/bash
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#
#  - ROS2 version: ROS2/jazzy(arm64v8)
#  - OS version:   Ubuntu 24.04/noble(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=jazzy

FROM  kullken/ros2_arm64v8:pet-base-jazzy
ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV WS_LOCAL="${HOMEDIR}/ws_ros2-local"
ENV VIRTUAL_ENV="${WS_LOCAL}/venv"
ENV DOCKERPROMPT="Pet-Mk.VIII[jazzy]"

LABEL description="Custom ROS2 jazzy image for Pet-Mk.VIII (aka. 'Dashboard') - Launch all basic ROS2 nodes"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.1"

# Add custom shell-prompt for this base-image to ~/.bashrc
USER ${DOCKERUSER}
RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> /home/pet/.bashrc

# Recreate/Pre-load the '.bash_history' for commands
USER root
COPY .bash_history ${HOMEDIR}/.bash_history
RUN chmod 600 ${HOMEDIR}/.bash_history &&\
    chown ${DOCKERUSER} ${HOMEDIR}/.bash_history &&\
    chgrp ${DOCKERUSER} ${HOMEDIR}/.bash_history 

# Setup entrypoint bash script file
USER root
COPY ros-entrypoint.sh ${HOMEDIR}/ros_entrypoint.sh
RUN chown ${DOCKERUSER} ${HOMEDIR}/ros_entrypoint.sh &&\
    chgrp ${DOCKERUSER} ${HOMEDIR}/ros_entrypoint.sh &&\
    chmod 755 ${HOMEDIR}/ros_entrypoint.sh

# Setup exit condtions
# ENTRYPOINT instruction is used to configure the executables that will always run after the container is initiated (not by '$ docker exec')
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
ENTRYPOINT ["/home/pet/ros_entrypoint.sh"]
CMD ["/bin/bash"]
# CMD ["ros2", "launch", "pet_mk_viii", "pet-mk-viii-bringup.launch.py"]
