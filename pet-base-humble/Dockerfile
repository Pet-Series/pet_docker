# Dockerfile: Base layer for ROS2/Humble running on Raspberry PI
# - ROS Version: ROS2/Humble(arm64)
# - OS version: Ubuntu 22.04
#----------------------

# Build Docker image with:
#----------------------
# $ docker build -t kullken/ros2_arm64v8:pet-base-humble .
#----------------------

# Launch Docker image with:
#----------------------
# $ docker run -it --rm --network=host --privileged kullken/ros2_arm64v8:pet-base-humble
#----------------------

#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#
# "humble"= ROS2
# "jammy"  = Ubuntu 22.04
#
# More info: 
#    - https://github.com/Pet-Series/pet_docker
#    - https://hub.docker.com/repositories/kullken
#    - https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
#    - https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble
#
FROM arm64v8/ros:humble-ros-base-jammy

ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Pet-Base-Humble"

LABEL description="ROS2 Humble image for RasperryPI with I2C & GPIO access"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.0"

SHELL ["/bin/bash", "-c"]

# Setup Docker user "pet" for access to i2c and GPIO
# Support Ubuntu 20.04 using group: dailout
# Support RaspianOS using groups:   spi,i2c,gpio
# gpio => ls -la /dev/gpiomem {Acces via group 'dialout' or 'gpio'}
# i2c  => ls -la /dev/i2c*    {Acces via group 'dialout' or 'i2c'}
# spi  => ls -la /dev/spi*    {Acces via group 'dialout' or 'spi'}
# USB  => ls -la /dev/ttyUSB* {Acces via group 'dialout'}
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

# Install required software i2c
USER root
RUN apt update -y &&\
    apt -y install i2c-tools python3-pip &&\
    rm -rf /var/lib/apt/lists/*

# Install Neofetch
RUN apt update -y &&\
    apt -y install neofetch &&\
    echo 'neofetch' >> /home/pet/.bashrc &&\
    rm -rf /var/lib/apt/lists/*

# Install Python3 extentions for I2C, GPIO and AD-converter
USER ${DOCKERUSER}
RUN pip3 install \
        RPi.GPIO \
        Adafruit_ADS1x15 \
        board \
        adafruit-blinka \
        gpio \
        lgpio \
        pigpio \
        smbus2 \
        gpiozero \
        rpi_lcd

# WARNING: The scripts pyserial-miniterm and pyserial-ports are installed in '/home/pet/.local/bin' which is not on PATH.
# WARNING: The scripts pinout and pintest are installed in '/home/pet/.local/bin' which is not on PATH.  

# Install GPIO-nice-to-have-tool, including $ gpioinfo
USER root
RUN apt update -y &&\
    apt -y install gpiod &&\
    rm -rf /var/lib/apt/lists/*

# Adding stuff to >> $~/.bashrc
USER ${DOCKERUSER}
RUN echo '# Setting up my own fancy Terminal Prompt :-)'                    >> ${HOMEDIR}/.bashrc &&\
    echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc &&\
    echo '# Setting up alias for sourcing ROS2'                             >> ${HOMEDIR}/.bashrc &&\
    echo "alias humble='source /opt/ros/humble/setup.bash'"                 >> ${HOMEDIR}/.bashrc &&\
    echo "alias pet_source='source /home/pet/ws_ros2/install/setup.bash'"   >> ${HOMEDIR}/.bashrc

# Setup exit condtions
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]