# Dockerfile: Simulation of Pet-Mk-IV.
# - ROS Version: ROS1/Noetic(linux/amd64)
# - OS version: Ubuntu 20.04 focal
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

# Setup Docker user "pet" for access to Sudo etc.
RUN groupadd --force --gid  20 dialout &&\
    groupadd --force --gid  27 sudo &&\
    groupadd --force --gid  44 video

RUN useradd \
        --uid 1000 \
        --shell /bin/bash \
        --home-dir ${HOMEDIR} \
        --create-home \
        --user-group \
        --groups dialout,sudo,video \
        ${DOCKERUSER} &&\
    echo "${DOCKERUSER}:d0cker" | chpasswd
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}

# Install git, python3/pip and catkin (so that we can build ROS1 workspaces)
USER root
RUN apt-get update &&\
    apt-get install -y git &&\
    apt-get install -y python3-pip &&\
    apt-get install -y python3-wstool &&\
    apt-get install -y python3-rosinstall-generator &&\
    apt-get install -y python3-catkin-lint &&\
    apt-get install -y python3-catkin-tools &&\
    apt-get install -y ros-noetic-teleop-twist-keyboard &&\
    apt-get install -y ros-noetic-xacro &&\
    apt-get install -y python3-osrf-pycommon &&\
    rm -rf /var/lib/apt/lists/*
# RUN pip3 install osrf-pycommon

# Lets make a Python/Python2 name-compatible executable of Python3
USER root
RUN ln -s /usr/bin/python3.8 /usr/bin/python

# Install Neofetch (not neccesary but fancy :-)
USER root
RUN apt update -y &&\
    apt -y install neofetch &&\
    echo 'neofetch' >> ${HOMEDIR}/.bashrc &&\
    rm -rf /var/lib/apt/lists/*

# Create ROS1 Workspace
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
RUN mkdir -p ~/ws_ros1/src 

# Clone git-repositories into the ROS1 workspace
WORKDIR ${HOMEDIR}/ws_ros1/src
RUN git clone https://github.com/Pet-Series/Pet-Mk-IV.git &&\
    git clone https://github.com/Pet-Series/pet_mk_iv_simulation.git
WORKDIR ${HOMEDIR}/ws_ros1
RUN source /opt/ros/noetic/setup.bash && catkin init
    # catkin_make

# Build the ROS1 workspace
WORKDIR ${HOMEDIR}/ws_ros1
RUN source /opt/ros/noetic/setup.bash &&\
    catkin build \
        pet_mk_iv_description \
        pet_mk_iv_msgs \
        pet_mk_iv_mission_control \
        pet_mk_iv_simulation

# Create the ~/.gazebo/gui.ini file
RUN mkdir ${HOMEDIR}/.gazebo
COPY gui.ini ${HOMEDIR}/.gazebo/gui.ini

# Recreate/Pre-load the '.bash_history' for commands
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
COPY .bash_history ${HOMEDIR}/.bash_history
USER root
RUN  chmod 600 ${HOMEDIR}/.bash_history && chown ${DOCKERUSER} ${HOMEDIR}/.bash_history  && sudo chgrp ${DOCKERUSER} ${HOMEDIR}/.bash_history 

# Adding stuff to >> $~/.bashrc
USER ${DOCKERUSER}
RUN echo '# Setting up my own fancy Terminal Prompt :-)' >> ${HOMEDIR}/.bashrc &&\
    echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc 

# Setting up ROS1/Noetic and Gazebo, by adding stuff to >> $~/.bashrc
USER ${DOCKERUSER}
RUN echo "# Setting up ROS1/Noetic and Gazebo" >> ${HOMEDIR}/.bashrc &&\
    echo 'source /opt/ros/noetic/setup.bash'          >> ${HOMEDIR}/.bashrc &&\
    echo 'source ${HOMEDIR}/ws_ros1/devel/setup.bash' >> ${HOMEDIR}/.bashrc &&\
    echo "alias source_noetic='source /opt/ros/noetic/setup.bash'"       >> ${HOMEDIR}/.bashrc &&\
    echo "alias source_pet='source ${HOMEDIR}/ws_ros1/devel/setup.bash'" >> ${HOMEDIR}/.bashrc &&\
    echo "export GAZEBO_RESOURCE_PATH=$HOME/ws_ros1/src/pet_mk_iv_simulation/worlds/:\${GAZEBO_RESOURCE_PATH}" >> ${HOMEDIR}/.bashrc &&\
    echo "export GAZEBO_MODEL_PATH=/usr/share/gazebo-11/models"                                                >> ${HOMEDIR}/.bashrc &&\
    echo "export GAZEBO_MODEL_PATH=$HOME/ws_ros1/src/pet_mk_iv_simulation/models:\${GAZEBO_MODEL_PATH}"        >> ${HOMEDIR}/.bashrc

# Setup exit condtions
USER root
RUN  chmod 700 ${HOMEDIR}/.bashrc
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}/ws_ros1
# CMD bash
# ENTRYPOINT /ros_entrypoint.sh