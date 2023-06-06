# Dockerfile: Simulation of Pet-Mk-IV.
# - ROS Version: ROS1/Noetic(linux/amd64)
# - OS version: Ubuntu 20.04 
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#----------------------

# Build Docker image with:
#----------------------
# $ docker build -t kullken/ros1_amd64:pet-mk-iv-simulation .
#----------------------

# Launch Docker image with:
#----------------------
# $ docker run \
#   -it \
#   --rm \
#   --network=host \
#   kullken/ros1_amd64:pet-mk-iv-simulation
#----------------------

# Some usefull links...
# https://hub.docker.com/r/osrf/ros/tags
# https://hub.docker.com/r/osrf/ros/tags?page=1&name=noetic
# https://hub.docker.com/repository/docker/kullken/ros1_amd64

FROM osrf/ros:noetic-desktop-full-focal

ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Pet-Noetic"

LABEL description="ROS1-Noetic with Ubuntu 20.04(focal) for AMD64"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.0"

SHELL ["/bin/bash", "-c"]

# Setup Docker user "pet" for access to Sudo
RUN groupadd --force --gid  20 dialout
RUN groupadd --force --gid  27 sudo
RUN groupadd --force --gid  44 video

RUN useradd \
    --uid 1000 \
    --shell /bin/bash \
    --home-dir ${HOMEDIR} \
    --create-home \
    --user-group \
    --groups dialout,sudo,video \
    ${DOCKERUSER}
RUN echo "${DOCKERUSER}:d0cker" | chpasswd
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}

RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc 

# Install git & python
USER root
RUN apt-get update
RUN apt-get install -y git && apt-get install -y python3-pip

# Install Neofetch
RUN sudo apt update -y && apt -y install neofetch && echo 'neofetch' >> ${HOMEDIR}/.bashrc
##    && rm -rf /var/lib/apt/lists/*

# Create ROS1 Workspace
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
RUN mkdir -p ~/ws_ros1/src 

# Clone git-repositories
WORKDIR ${HOMEDIR}/ws_ros1/src
RUN git clone https://github.com/Pet-Series/Pet-Mk-IV.git && \
    git clone https://github.com/Pet-Series/pet_mk_iv_simulation.git

USER ${DOCKERUSER}
RUN echo 'source /opt/ros/noetic/setup.bash' >> ${HOMEDIR}/.bashrc
RUN echo "alias source_noetic='source /opt/ros/noetic/setup.bash'" >> ${HOMEDIR}/.bashrc
RUN echo "alias source_pet='source ${HOMEDIR}/ws_ros1/devel/setup.bash'" >> ${HOMEDIR}/.bashrc

# Setup exit condtions
WORKDIR ${HOMEDIR}/ws_ros1
CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]