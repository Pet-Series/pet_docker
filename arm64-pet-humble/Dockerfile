# This is an ./Dockerfile for my custom Docker 'Base' Image
#   Level 0) Docker 'Source' Image   = arm64v8/ros:humble-ros-base-jammy
#   Level 1) Docker 'Base' Image     = kullken/ros2_arm64v8:pet-base-humble <-This ./Dockerfile 
#   Level 3) Docker 'Overlay' Image  = n/a 
# 
# Description:
#   Target hardware platform: Any Raspberry PI3..5[arm64v8].
#   Running Ubuntu with Robot Operating System 2(ROS2)
#   Interact with local RPi hardware as GPIO, I2C and SPI.
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
#  - ROS2 version: ROS2/humble(arm64v8)
#  - OS version:   Ubuntu 22.04/jammy(arm64v8)
#
# More info: 
#  - https://github.com/Pet-Series/pet_docker
#  - https://hub.docker.com/repositories/kullken
#  - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#  - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble

FROM arm64v8/ros:humble-ros-base-jammy

ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Pet-Base-Humble"

LABEL description="ROS2 Humble Base Docker Image for any Raspberry PI3..5 (hw. access: GPIO, I2C and SPI )"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.0"

SHELL ["/bin/bash", "-c"]

# Setup Docker user "pet" for access to i2c and GPIO
# - Ubuntu 20.04/22.04/24.04 using group: dailout, video
# - RaspianOS using groups: spi,i2c,gpio
# Group 'dialout' => ls -la /dev/gpiomem   {Note! Part of the '/dev/mem' that is used for the gpio}
# Group 'dialout' => ls -la /dev/i2c*      {Note! Could be 1 or 2 i2c ports}
# Group 'dialout' => ls -la /dev/spi*
# Group 'dialout' => ls -la /dev/ttyUSB*
# Group 'video'   => ls -la /dev/vchiq
# Group 'dialout' => ls -la /dev/gpiochip*  {Note! Differs from RPi3 -> RPi4 -> RPi5} 
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
# Install 'python3-pip' Python3 install tool, including '$ pip3'
# Install 'gpiod' GPIO-nice-to-have-tool, including '$ gpioinfo'
USER root
RUN apt-get update -y &&\
    apt-get -y install \
        i2c-tools \
        python3-pip \
        gpiod &&\
    rm -rf /var/lib/apt/lists/*

# Install Python3 extensions for I2C, GPIO and AD-converter
USER ${DOCKERUSER}
RUN pip3 install \
        RPi.GPIO \
        adafruit-blinka \
        Adafruit_ADS1x15 \
        adafruit-circuitpython-ads1x15 \
        adafruit-circuitpython-ina219 \
        gpio \
        lgpio \
        pigpio \
        smbus2 \
        gpiozero \
        rpi_lcd

# Stuff...
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
RUN echo "Created this file so I do not get the annoying messages 'To run a command as administrator...'" > ~/.sudo_as_admin_successful

# Adding stuff to existing  >> $~/.bashrc
USER ${DOCKERUSER}
RUN echo '\n# Setting up my own fancy Terminal Prompt :-)'                    >> ${HOMEDIR}/.bashrc &&\
    echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc &&\
    echo '\n# Setting up alias for sourcing ROS2'                             >> ${HOMEDIR}/.bashrc &&\
    echo "alias humble='source /opt/ros/humble/setup.bash'"                 >> ${HOMEDIR}/.bashrc &&\
    echo "alias pet_source='source /home/pet/ws_ros2/install/setup.bash'"   >> ${HOMEDIR}/.bashrc

# Setup exit conditions
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]