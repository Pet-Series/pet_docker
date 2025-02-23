# This is an ./Dockerfile for my custom Docker 'Base' Image
#   Level 1) Docker 'Source' Image:
#            1.1 FROM ubuntu:noble
#            1.2 FROM osrf/ros:jazzy-desktop-full
#            1.3 => osrf/ros:jazzy-desktop-full-noble
#   Level 2) My own custom Docker 'Base' Image:
#            2.1 FROM osrf/ros:jazzy-desktop-full-noble
#            2.0 => kullken/ros2_amd64:jazzy-full
#   Level 3) Docker 'Overlay' Image
#            3.1 kullken/ros2_amd64:jazzy-full
#            3.2 => n/a 
#----------------------
# Build this Docker image with:
#   $ docker build --tag kullken/ros2_amd64:jazzy-full .
#   $ docker run  -it --rm --network=host kullken/ros2_amd64:jazzy-full
#      OR
# Build Docker Image and launch Docker Container with:
#   $ docker compose up --detach
#   $ docker exec -it jazzy-full-container bash
# 
#----------------------
# Maintainer: stefan.kull@gmail.com
# License: MIT
# https://github.com/Pet-Series
#
#  - "kullken"      = DockerWeb User
#  - "ros2_amd64"   = DockerWeb Repository
#  - "jazzy-full"   = DockerWeb Tag
#
#  - ROS2 version: ROS2/Jazzy Jalisco(amd64/PC)
#  - OS version:   Ubuntu 24.04/noble(amd64/PC)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_amd64
#  - https://hub.docker.com/repository/docker/kullken/ros2_amd64/tags?name=jazzy
#  - https://hub.docker.com/r/osrf/ros/tags?page=1&name=jazzy

ARG ROS_DISTRO="jazzy"
# ARG GZ_VERSION="harmonic"
FROM osrf/ros:${ROS_DISTRO}-desktop-full-noble
ENV DEBIAN_FRONTEND=noninteractive

ENV DOCKERPROMPT="Base[${ROS_DISTRO}]"

ENV DOCKERUSER="ubuntu"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV ROS_WSDIR="${HOMEDIR}/ws_ros2_${ROS_DISTRO}"

LABEL description="Custom ROS2 ${ROS_DISTRO} base (Ubuntu 24.04) image for PC with AMD64/x486"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.1"

SHELL ["/bin/bash", "-c"]

# Update existing user 'ubuntu' and make sure that the groups are set correctly.
# - Set password... To avoid mistakes :)
# - Add user to 'adm'     group GID:4   <= Needed for 'log' access
# - Add user to 'dailout' group GID:20  <= Needed for 'modem' and 'tty' access
# - Add user to 'audio'   group GID:29  <= Needed direct I/O access of 'microphone' & 'speaker' from inside the container.
# - Add user to 'video'   group GID:44  <= Needed for GUI access 'Graphics stuff' from inside the container to access docker-host xhost/X11 screen & Webcam etc.
# - Add user to 'render'  group GUD:992 <= Needed for GUI access 'Graphics stuff' from inside the container to access docker-host xhost/X11 screen.
# - Add user to 'input'   group GID:995 <= Needed direct I/O access of 'Joystick' from inside the container.

USER root
RUN echo "${DOCKERUSER}:D0cker" | chpasswd

RUN  groupadd --force --gid  20 dailout &&\
     groupadd --force --gid  44 video &&\
     groupadd --force --gid 992 render &&\
     groupadd --force --gid 995 input &&\
     usermod -aG adm     ${DOCKERUSER} &&\
     usermod -aG dailout ${DOCKERUSER} &&\
     usermod -aG audio   ${DOCKERUSER} &&\
     usermod -aG video   ${DOCKERUSER} &&\
     usermod -aG plugdev ${DOCKERUSER} &&\
     usermod -aG render  ${DOCKERUSER} &&\
     usermod -aG input   ${DOCKERUSER}

# Upgrade all packages
USER root
RUN  apt-get -y update &&\
     apt-get -y upgrade &&\
     apt-get -y autoremove &&\
     rm -rf /var/lib/apt/lists/*
     # Or 'apt-get clean'
     # Or 'apt-get autoclean'

# Install 'neofetch' generate fancy login banner
# Install 'nano' minimal editor
# Install 'gedit' graphical editor
# Install 'htop'  process viewer
# Install 'wget'  download manager
USER root
RUN  apt-get -y update &&\
     apt-get -y install neofetch &&\
     apt-get -y install nano &&\
     apt-get -y install gedit &&\
     apt-get -y install htop &&\
     apt-get -y install wget &&\
     apt-get -y autoremove &&\
     rm -rf /var/lib/apt/lists/*
     # Or 'apt-get clean'
     # Or 'apt-get autoclean'

# Install 'ros2 gz(Gazebo) & rqt stuff and rqt plugins'
USER root
RUN  apt-get -y update &&\
     apt-get -y install ros-${ROS_DISTRO}-ros2-controllers &&\
     apt-get -y install ros-${ROS_DISTRO}-ros2-control &&\
     apt-get -y install ros-${ROS_DISTRO}-gz-ros2-control &&\
     apt-get -y install ros-${ROS_DISTRO}-ros-gz &&\
     apt-get -y install ros-${ROS_DISTRO}-ros-gz-bridge &&\
     apt-get -y install ros-${ROS_DISTRO}-joint-state-publisher &&\
     apt-get -y install ros-${ROS_DISTRO}-robot-state-publisher &&\
     apt-get -y install ros-${ROS_DISTRO}-xacro &&\
     apt-get -y install ros-${ROS_DISTRO}-joy &&\
     apt-get -y install '~nros-${ROS_DISTRO}-rqt*' &&\
     apt-get -y autoremove &&\
     rm -rf /var/lib/apt/lists/*
     # Or 'apt-get clean'
     # Or 'apt-get autoclean'

# <<<<< Start: This will most likely go into a separate Docker Layer >>>>>
# Install 'Graphics stuff'
# - Intel Graphics Compute Runtime for OpenCL
# - Intel Graphics Stack
# - Mesa 3D graphics library
# - Mesa-utils (glxinfo and glxgears)
USER root
RUN  wget -qO - https://repositories.intel.com/gpu/intel-graphics.key | \
          gpg --yes --dearmor --output /usr/share/keyrings/intel-graphics.gpg &&\
     echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/gpu/ubuntu noble unified" | \
          tee /etc/apt/sources.list.d/intel-gpu-noble.list&&\
     apt-get -y update &&\
     apt-get -y upgrade &&\
     apt-get -y install libze-intel-gpu1 libze1 intel-opencl-icd clinfo intel-gsc &&\
     apt-get -y install libgl1-mesa-dri &&\
     apt-get -y install mesa-utils &&\
     apt-get -y install clinfo &&\
     apt-get -y autoremove &&\
     rm -rf /var/lib/apt/lists/*
     # Or 'apt-get clean'
     # Or 'apt-get autoclean'
# <<<<< End: This will most likely go into a separate Docker Layer >>>>>

# <<<<< Start: This will most likely go into a separate Docker Layer >>>>>
# Install 'Joystick/Xbox stuff' & 'USB stuff'
# - usbutils:   $ lsusb + $ lsusb --tree + lsusb -D /dev/bus/usb/001/126   # List USB devices
# - udev:       $ udevadm info -a -n /dev/input/js0  + $ udevadm monitor --udev # Monitor udev/usb events
# - jstest-gtk: Joystick tester via GUI
# - xxd:        $ xxd /dev/input/mouse4 # Hexdump
USER root
RUN  apt-get -y update &&\
     apt-get -y install usbutils &&\
     apt-get -y install udev &&\
     apt-get -y install jstest-gtk &&\
     apt-get -y install xxd &&\
     apt-get -y autoremove &&\
     rm -rf /var/lib/apt/lists/*
# <<<<< End: This will most likely go into a separate Docker Layer >>>>>

# Created '~/.sudo_as_admin_successful' so I do not get the annoying messages 'To run a command as administrator...'
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
RUN  echo "Created this file so I do not get the annoying messages 'To run a command as administrator...'" > ~/.sudo_as_admin_successful

# Adding stuff to existing >> $~/.bashrc
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
RUN  echo '# Setting up my own fancy Terminal Prompt :-)'                     >> ${HOMEDIR}/.bashrc &&\
     echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc &&\
     echo '# Setting up alias for sourcing ROS2'                              >> ${HOMEDIR}/.bashrc &&\
     echo "alias ${ROS_DISTRO}='source /opt/ros/${ROS_DISTRO}/setup.bash'"    >> ${HOMEDIR}/.bashrc &&\
     echo "alias pet_source='source ${ROS_WSDIR}/install/setup.bash'"         >> ${HOMEDIR}/.bashrc &&\
     echo "alias build='cd ${ROS_WSDIR} && colcon build --symlink-install' && 'source ${ROS_WSDIR}/install/setup.bash'"   >> ${HOMEDIR}/.bashrc &&\
     echo '# Launch "neofetch" in each terminal'                              >> ${HOMEDIR}/.bashrc &&\
     echo 'neofetch'                                                          >> ${HOMEDIR}/.bashrc 

# Setup exit conditions
ENV  DEBIAN_FRONTEND=
USER ${DOCKERUSER}
WORKDIR ${ROS_WSDIR}
CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]
