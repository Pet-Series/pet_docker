# Dockerfile: Base layer for ROS2/Humble running on Raspberry PI
# - ROS Version: ROS2/Humble(arm64)
# - OS version: Ubuntu 22.04
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#----------------------

# Build Docker image with:
#----------------------
# $ docker build -t kullken/ros2_arm64v8:pet-base-humble .
#----------------------

# Launch Docker image with:
#----------------------
# $ docker run -it --rm --network=host --privileged kullken/ros2_arm64v8:pet-base-humble
#----------------------

# Some usefull links...
# https://hub.docker.com/r/arm64v8/ros/tags
# https://hub.docker.com/r/arm64v8/ros/tags?page=1&name=humble
# https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
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

RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc 

# Install required software i2c
USER root
RUN apt update -y && apt -y install i2c-tools python3-pip
##    && rm -rf /var/lib/apt/lists/*

# Install Neofetch
RUN sudo apt update -y && apt -y install neofetch && echo 'neofetch' >> /home/pet/.bashrc 
##    && rm -rf /var/lib/apt/lists/*

# Install Python3 extentions for I2C, GPIO and AD-converter
USER ${DOCKERUSER}
RUN pip3 install \
        RPi.GPIO \
        Adafruit_ADS1x15 \
        board \
        adafruit-blinka \
        lgpio \
        smbus2 \
        gpiozero \
        rpi_lcd
# WARNING: The scripts pyserial-miniterm and pyserial-ports are installed in '/home/pet/.local/bin' which is not on PATH.

# Install VisualCode
# USER root
# RUN apt update -y && apt -y install software-properties-common apt-transport-https wget
#RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
#RUN wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /usr/share/keyrings/vscode.gpg
#RUN add-apt-repository "deb [arch=arm64] https://packages.microsoft.com/repos/vscode stable main"
#RUN echo deb [arch=arm64 signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | tee /etc/apt/sources.list.d/vscode.list
#RUN apt update -y && apt install -y code
USER ${DOCKERUSER}
RUN echo "alias humble='source /opt/ros/humble/setup.bash'" >> ${HOMEDIR}/.bashrc
RUN echo "alias pet_source='source /home/pet/ws_ros2/install/setup.bash'" >> ${HOMEDIR}/.bashrc

# Setup exit condtions
CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]
