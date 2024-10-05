# Dockerfile: Target HW/Platform Pet-Mk-V (Five)
# - ROS Version: ROS2/Humble(arm64)
# - OS version: Ubuntu 22.04
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#----------------------

# Build Docker image with:
#----------------------
# $ docker build --tag kullken/ros2_arm64v8:pet-mk-v-runtime .
#----------------------

# Launch Docker image with:
#----------------------
# $ docker run \
#   -it \
#   --rm \
#   --network=host \
#   --privileged \
#   --volume="/home/pi/ws_ros2:/home/pet/ws_ros2" \
#   kullken/ros2_arm64v8:pet-mk-v-runtime

#----------------------
# Prerequisit: Docker host must clone https://github.com/Pet-Series/Pet-Mk-VIII.git
#

# Some usefull links...
# https://hub.docker.com/r/arm64v8/ros/tags
# https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble
# https://hub.docker.com/repository/docker/kullken/ros2_arm64v8

FROM  kullken/ros2_arm64v8:pet-base-humble 
ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Pet-Mk.V"

LABEL description="ROS2 Humble image for Pet-Mk.V - Launch all basic ROS2 nodes"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.0"

SHELL ["/bin/bash", "-c"]

USER ${DOCKERUSER}

# Add custom shell-prompt for this Pet to ~/.bashrc
RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc 

# Add setup.bash to ~/.bashrc
RUN echo 'source ${HOMEDIR}/ws_ros2/install/setup.bash' >> ${HOMEDIR}/.bashrc 

# Put the entrypoint.sh script in the right place...
COPY ./entrypoint.sh ${HOMEDIR}/entrypoint.sh
USER root
RUN chmod +x         ${HOMEDIR}/entrypoint.sh
USER ${DOCKERUSER}

# As default - Bring Bash-shell
CMD ["/bin/bash"]
ENTRYPOINT ["/home/pet/entrypoint.sh"]