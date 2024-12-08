# This is an ./Dockerfile for my custom Docker 'Base' Image
#   Level 1) Docker 'Source' Image
#            1.1 FROM ubuntu:noble
#            1.2 FROM arm64v8/ros:jazzy-ros-base-noble
#   Level 2) Docker 'Base' Image     
#            2.0 This Image = kullken/ros2_arm64v8:pet-base-jazzy
#   Level 3) Docker 'Overlay' Image
#            3.0 n/a 
# This is an ./Dockerfile for my custom Docker 'Base' Image
#   Level 0) Docker 'Source' Image   = arm64v8/ros:jazzy-ros-base-noble
#   Level 1) Docker 'Base' Image     = kullken/ros2_arm64v8:pet-base-jazzy <-This Image
#   Level 3) Docker 'Overlay' Image  = n/a 
# 
# Description:
#   Target hardware platform: Any Raspberry PI3..5[arm64v8].
#   Running Ubuntu with Robot Operating System 2(ROS2)
#   Interact with local RPi hardware as GPIO, I2C and SPI.
#
# Prerequisite - On docker host before building/starting Docker Image/Container:
#   a)  Raspberry Pi3..5 running Ubuntu and Docker installed.
#       /dev/vchiq 
#   b)  That '$ xhost local:docker' is started before the container is started. 
#       To enable GUI/X11 applications inside the container
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
#  - ROS2 Version: ROS2/jazzy(arm64)
#  - OS version:   Ubuntu 24.04/noble
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=jazzy

FROM arm64v8/ros:jazzy-ros-base-noble
ENV DEBIAN_FRONTEND=noninteractive

ARG ROS_DISTRO="jazzy"
ARG DOCKERPROMPT="Pet-Base[${ROS_DISTRO}]"

ARG DOCKERUSER="pet"
ARG DOCKERUSER_UID=1000
ARG DOCKERUSER_GID=$DOCKERUSER_UID
ENV HOMEDIR="/home/${DOCKERUSER}"

# # Setup a Python3 virtual environment 
# ENV WS_LOCAL="${HOMEDIR}/ws_ros2-local"
# ENV VIRTUAL_ENV="${WS_LOCAL}/venv"

LABEL description="Custom ROS2 ${ROS_DISTRO} base (Ubuntu 24.04) image for RaspberryPI(arm64) with support for hardware access like I2C, GPIO and SPI."
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.0"

SHELL ["/bin/bash", "-c"]

# Setup Docker user "pet" for access to i2c and GPIO
# - Ubuntu 20.04 via OSRF using
# - Ubuntu 20.04/22.04/24.04 using group: dailout, video
# - RaspianOS using groups: spi,i2c,gpio
# Group 'dialout' => ls -la /dev/gpiomem   {Note! Part of the '/dev/mem' that is used for the gpio}
# Group 'dialout' => ls -la /dev/i2c*      {Note! Could be 1 or 2 i2c ports}
# Group 'dialout' => ls -la /dev/spi*
# Group 'dialout' => ls -la /dev/ttyUSB*
# Group 'video'   => ls -la /dev/vchiq
# Group 'dialout' => ls -la /dev/gpiochip*  {Note! Differs from RPi3 -> RPi4 -> RPi5} 

# Remove Ubuntu/Image default user = 1000:1000 with name 'ubuntu'
# Create new user = 1000:1000 with name '${DOCKERUSER}' 


# Check if "ubuntu" user exists, delete it if it does, then create the desired user
USER root
RUN if getent passwd ubuntu > /dev/null 2>&1; then \
        userdel --remove ubuntu && \
        echo ">>>>Deleted existing ubuntu user"; \
    fi && \
    useradd \
        --uid ${DOCKERUSER_UID} \
        --gid ${DOCKERUSER_GID} \
        --shell /bin/bash \
        --create-home \
        --home-dir ${HOMEDIR} \
        --user-group \
        --groups adm,dialout,sudo,video,audio,plugdev,dip \
        --password d0cker \
        ${DOCKERUSER} && \
    echo ">>>>reated new user $USERNAME"

# Add sudo support for the non-root user
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${DOCKERUSER}\
  && chmod 0440 /etc/sudoers.d/${DOCKERUSER} \
  && rm -rf /var/lib/apt/lists/*

# Install 'nano' nice-to-have-tool as text editor
# Install 'i2c-tools' I2C-required software, including '$ i2cdetect'
# Install 'gpiod' GPIO-nice-to-have-tool, including '$ gpioinfo'
# Install 'net-tool' LAN-nice-to-have-tool, including '$ ifconfig'
# Install 'libraspberrypi-bin' tool view VideoCore GPU information on the Raspberry Pi, including '$ vcgencmd'
# Install 'neofetch' nice-to-have-tool that shows os/linux info + ASCII-art stuff.
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
        nano \
        i2c-tools \
        net-tools \
        libraspberrypi-bin \
        gpiod &&\
    apt-get install -y \
        neofetch &&\
        echo '# Launch "neofetch" in each terminal' >> /home/pet/.bashrc &&\
        echo 'neofetch' >> /home/pet/.bashrc &&\
    rm -rf /var/lib/apt/lists/*

# Install Python3 extensions for I2C, GPIO and SPI
# - Note: If possible try find .deb package via '$ apt-get install', instead of using '$ pip3 install',
#         due to risk of introducing dependencies mismatch when using '$ pip3 install'
USER root
RUN apt-get update -y &&\
    apt-get install -y --upgrade \
        python3-setuptools &&\
    apt-get install -y --no-install-recommends\
        pipx \
        python3-pip \
        python3-lgpio \
        python3-rpi-lgpio \
        python3-smbus2 \
        python3-gpiozero \
        python3-venv &&\
        rm -rf /var/lib/apt/lists/*

# # Setup a local ROS2 Workspace in local Docker file system
# USER ${DOCKERUSER}
# RUN mkdir -p ${WS_LOCAL}/src
# RUN cd ${WS_LOCAL}
# RUN /bin/bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash; colcon build --symlink-install"

# # Setup a Python3 virtual environment in the local ROS2 workspace
# USER ${DOCKERUSER}
# RUN python3 -m venv --system-site-packages ${VIRTUAL_ENV}
# RUN echo "Colcon (ROS2) should not try to build this directory ($VIRTUAL_ENV)" > ${VIRTUAL_ENV}/COLCON_IGNORE
# source ./venv/bin/activate
# ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

# Install Python3 extensions/libraries for I2C, GPIO + Drivers for sensors/actuators
# TODO:   As long as Ubuntu 23.xx/24.xx, Python 3.xx and ROS2 fucks up the Python Virtual Environment
#         We must use the ugly '$ pip3 install --break-system-packages' parameter to avoid <<error: externally-managed-environment>>
USER ${DOCKERUSER}
RUN pip3 install --break-system-packages \
         adafruit-blinka \
         adafruit-circuitpython-ads1x15 \
         adafruit-circuitpython-ina219 \
         adafruit-circuitpython-mpu6050 \
         adafruit-circuitpython-vl53l1x \
         RaspberryPiVcgencmd

# Stuff...
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
RUN echo "Created this file so I do not get the annoying messages 'To run a command as administrator...'" > ~/.sudo_as_admin_successful

# Adding stuff to existing >> $~/.bashrc
USER ${DOCKERUSER}
RUN echo '# Setting up my own fancy Terminal Prompt :-)'                    >> ${HOMEDIR}/.bashrc &&\
    echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc &&\
    echo '# Setting up alias for sourcing ROS2'                             >> ${HOMEDIR}/.bashrc &&\
    echo "alias ${ROS_DISTRO}='source /opt/ros/${ROS_DISTRO}/setup.bash'"   >> ${HOMEDIR}/.bashrc &&\
    echo "alias pet_source='source /home/pet/ws_ros2/install/setup.bash'"   >> ${HOMEDIR}/.bashrc

# Setup exit conditions
ENV DEBIAN_FRONTEND=
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]