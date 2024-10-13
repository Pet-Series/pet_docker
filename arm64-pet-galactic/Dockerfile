# Dockerfile: Base layer for ROS2/galactic, inclluding ros-bridge to ROS1/noetic+melodic, running on Raspberry Pi 4/5
# 
# Build Docker image with:
#----------------------
# $ docker build -t kullken/ros2_arm64v8:pet-base-galactic .
#----------------------
#
# Launch Docker image with:
#----------------------
# $ docker run -it --rm --network=host --privileged kullken/ros2_arm64v8:pet-base-galactic
#----------------------
#
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
#
# "galactic" = ROS2
# "focal"  = Ubuntu 20.04 
#
# More info: https://github.com/Pet-Series/pet_docker
# More info: https://hub.docker.com/repositories/kullken
# More info: https://hub.docker.com/repository/docker/kullken/ros2_arm64v8
FROM arm64v8/ros:galactic-ros1-bridge-focal

ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Pet-Base[Galactic]"

LABEL description="ROS2 galactic with ros1-bridge image for RasperryPI with I2C & GPIO access"
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

RUN echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc 

# Install required software i2c
USER root
RUN apt update -y && apt -y install i2c-tools python3-pip &&\
    rm -rf /var/lib/apt/lists/*

# Install Neofetch
USER root
RUN apt update -y && apt -y install neofetch && echo 'neofetch' >> /home/pet/.bashrc &&\
    rm -rf /var/lib/apt/lists/*

# Install Python3 extentions for I2C, GPIO and AD-converter
USER root
RUN pip3 install swig
USER ${DOCKERUSER}
RUN pip3 install RPi.GPIO
RUN pip3 install Adafruit_ADS1x15
RUN pip3 install board
RUN pip3 install adafruit-blinka
#RUN pip3 install lgpio
RUN pip3 install smbus2
RUN pip3 install gpiozero
RUN pip3 install rpi_lcd

# RUN pip3 install \
#         RPi.GPIO \
#         Adafruit_ADS1x15 \
#         board \
#         adafruit-blinka \
#         lgpio \
#         smbus2 \
#         gpiozero \
#         rpi_lcd
# WARNING: The scripts pyserial-miniterm and pyserial-ports are installed in '/home/pet/.local/bin' which is not on PATH!

# Put the Docker ros_entrypoint.sh script in the right place...
USER ${DOCKERUSER}
#COPY ./ros-entrypoint.sh ${HOMEDIR}/ros-entrypoint.sh
COPY ./ros-entrypoint.sh ${HOMEDIR}
USER root
RUN  chmod 755 ${HOMEDIR}/ros-entrypoint.sh && chown ${DOCKERUSER} ${HOMEDIR}/ros-entrypoint.sh  && sudo chgrp ${DOCKERUSER} ${HOMEDIR}/ros-entrypoint.sh

# Adding stuff to >> $~/.bashrc
USER ${DOCKERUSER}
RUN echo '# Setting up my own fancy Terminal Prompt :-)' >> ${HOMEDIR}/.bashrc &&\
    echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc &&\
    echo '#'                                                     >> ${HOMEDIR}/.bashrc &&\
    echo '# Setting up ROS2'                                     >> ${HOMEDIR}/.bashrc &&\
    echo 'source /opt/ros/galactic/setup.bash'                   >> ${HOMEDIR}/.bashrc &&\
    echo 'source ${HOMEDIR}/ws_ros2-galactic/install/setup.bash' >> /home/pet/.bashrc &&\
    echo "alias source_galactic='source /opt/ros/galactic/setup.bash'"            >> ${HOMEDIR}/.bashrc &&\
    echo "alias source_noetic='source /opt/ros/noetic/setup.bash'"                >> ${HOMEDIR}/.bashrc &&\
    echo "alias source_pet='source ${HOMEDIR}/ws_ros2-galactic/devel/setup.bash'" >> ${HOMEDIR}/.bashrc

# Setup exit condtions
USER ${DOCKERUSER}
#CMD ["/bin/bash"]
CMD /bin/bash
ENTRYPOINT ["/home/pet/ros-entrypoint.sh"]