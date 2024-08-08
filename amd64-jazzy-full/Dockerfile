# Dockerfile: Base layer for ROS2/Jazzy running on AMD64
# - ROS Version: ROS2 2024    LTS(amd64) aka."Jazzy"
# - OS version : Ubuntu 24.04 LTS(amd64) aka."noble"
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#----------------------
#
# Build this Docker image with:
#----------------------
# $ docker build -t kullken/ros2_amd64:jazzy-full .
#----------------------

# Launch this Docker image with:
#----------------------
# $ docker run  -it --rm --network=host kullken/ros2_amd64:jazzy-full
#----------------------

# Links to source/original...
# https://hub.docker.com/r/arm64v8/ros/tags
# https://hub.docker.com/r/arm64v8/ros/tags?name=jazzy
# https://hub.docker.com/r/osrf/ros/tags?name=jazzy
# Links to my custom content...
# https://hub.docker.com/r/kullken/
# https://hub.docker.com/repository/docker/kullken/ros2_amd64
# https://github.com/Pet-Series/pet_docker
FROM osrf/ros:jazzy-desktop-full-noble

ENV DOCKERUSER="ubuntu"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Jazzy-full"

LABEL description="ROS2 Jazzy image for PC with AMD64/x486"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.0"

SHELL ["/bin/bash", "-c"]

USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}

# Define prompt "🐳Jazzy-full_ubuntu@yoda:~$"
RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc 

# Install Neofetch
USER root
RUN apt update -y && apt -y install neofetch && echo 'neofetch' >> ${HOMEDIR}/.bashrc 
##    && rm -rf /var/lib/apt/lists/*


USER ${DOCKERUSER}
RUN echo "source /opt/ros/jazzy/setup.bash" >> ${HOMEDIR}/.bashrc
RUN echo "alias jazzy='source /opt/ros/jazzy/setup.bash'" >> ${HOMEDIR}/.bashrc
RUN echo "alias my_source='source /home/ubuntu/ws_ros2/install/setup.bash'" >> ${HOMEDIR}/.bashrc

# Setup exit condtions
CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]
