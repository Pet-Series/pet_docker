# This is an ./Dockerfile for my custom Docker 'Base' Image
#   Level 0) Docker 'Source' Image   = arm64v8/ros:galactic-ros1-bridge-focal
#   Level 1) Docker 'Base' Image     = kullken/ros2_arm64v8:pet-base-galactic <-This ./Dockerfile 
#   Level 3) Docker 'Overlay' Image  = n/a 
# 
# Description:
#   Target hardware platform: Any Raspberry PI3..5[arm64v8].
#   Running Ubuntu with Robot Operating System (ROS1/ROS2)
#   - Coexistences of both old ROS1/noetic+melodic old ROS2/galactic
#   - Purpose is to be able to run 'ros1-ros2 bridge'...
#   Interact with local RPi hw. as GPIO, I2C and SPI.
#
# Prerequisite - On docker host before building/starting Docker Image/Container:
#   a)  Raspberry Pi3..5 running Ubuntu and Docker installed.
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
#  - ROS2 version: ROS2/Galactic Geoclone(arm64v8)    <- No longer supported
#  - ROS1 version: ROS1/Noetic Ninjemys(arm64v8)      <- No longer supported
#  - OS version:   Ubuntu 20.04 LTS/Focal Fossa(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/_/ros
#  - https://index.ros.org/p/ros1_bridge/github-ros2-ros1_bridge/
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=galactic
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=noetic

FROM arm64v8/ros:galactic-ros1-bridge-focal

ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Pet-Base[Galactic/Noetic]"

LABEL description="ROS2 galactic with ros1-bridge image for RaspberryPI, including I2C & GPIO access"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="2.0"

SHELL ["/bin/bash", "-c"]

# Setup Docker user "pet" for access to i2c and GPIO
# Support Ubuntu 20.04 using group: dailout
# Support RaspianOS using groups:   spi,i2c,gpio
# gpio => ls -la /dev/gpiomem {Access via group 'dialout' or 'gpio'}
# i2c  => ls -la /dev/i2c*    {Access via group 'dialout' or 'i2c'}
# spi  => ls -la /dev/spi*    {Access via group 'dialout' or 'spi'}
# USB  => ls -la /dev/ttyUSB* {Access via group 'dialout'}
USER root
RUN groupadd --force --gid 997 gpio
RUN groupadd --force --gid 998 i2c
RUN groupadd --force --gid 999 spi
RUN groupadd --force --gid  20 dialout
RUN groupadd --force --gid  27 sudo
RUN groupadd --force --gid  44 video

RUN useradd \
    --uid 1000 \
    --shell /bin/bash \
    --home-dir ${HOMEDIR} \
    --create-home \
    --user-group \
    --groups gpio,i2c,spi,dialout,sudo,video \
    ${DOCKERUSER}
RUN echo "${DOCKERUSER}:d0cker" | chpasswd
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}

# Install 'neofetch' nice-to-have-tool that shows os/linux info + ASCII-art stuff.
# Install 'nano' nice-to-have-tool as text editor
USER root
RUN apt-get update -y &&\
    apt-get install -y neofetch &&\
        echo '# Launch "neofetch" in each terminal' >> /home/pet/.bashrc &&\
        echo 'neofetch' >> /home/pet/.bashrc &&\
    apt-get install -y nano &&\
    rm -rf /var/lib/apt/lists/*

# Install 'i2c-tools' I2C-required software, including '$ i2cdetect'
# Install 'gpiod' GPIO-nice-to-have-tool, including '$ gpioinfo'
# Install 'net-tool' LAN-nice-to-have-tool, including '$ ifconfig'
# Install 'libraspberrypi-bin' tool view VideoCore GPU information on the Raspberry Pi, including '$ vcgencmd'
USER root
RUN apt-get update -y &&\
    apt-get install -y \
        i2c-tools \
        net-tools \
        libraspberrypi-bin \
        gpiod &&\
    rm -rf /var/lib/apt/lists/*

# Install Python3 extensions/libraries for I2C, GPIO + Drivers for sensors/actuators
USER root
RUN pip3 install swig
USER ${DOCKERUSER}
RUN pip3 install \
        RPi.GPIO \
        adafruit-blinka \
        Adafruit_ADS1x15 \
        adafruit-circuitpython-ads1x15 \
        adafruit-circuitpython-ina219 \
        gpio \
        pigpio \
        smbus2 \
        gpiozero \
        rpi_lcd
# RUN pip3 install lgpio
# WARNING: The scripts pyserial-miniterm and pyserial-ports are installed in '/home/pet/.local/bin' which is not on PATH!

# Stuff...
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
RUN echo "Created this file so I do not get the annoying messages 'To run a command as administrator...'" \
          > ~/.sudo_as_admin_successful

# Adding stuff to existing  >> $~/.bashrc
USER ${DOCKERUSER}
RUN echo '# Setting up my own fancy Terminal Prompt :-)'                  >> ${HOMEDIR}/.bashrc &&\
    echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc &&\
    echo '# Setting up ROS1 and ROS2'                                     >> ${HOMEDIR}/.bashrc &&\
    echo 'source /opt/ros/noetic/setup.bash'                                >> ${HOMEDIR}/.bashrc &&\
    echo 'source /opt/ros/galactic/setup.bash'                              >> /home/pet/.bashrc &&\
    echo "alias noetic='source /opt/ros/noetic/setup.bash'"                 >> ${HOMEDIR}/.bashrc &&\
    echo "alias galactic='source /opt/ros/galactic/setup.bash'"             >> ${HOMEDIR}/.bashrc &&\
    echo "alias pet_source='source ${HOMEDIR}/ws_ros2-galactic/install/setup.bash'" >> ${HOMEDIR}/.bashrc

# Setup exit conditions
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]