# Dockerfile
# Custom ROS2 / Ubuntu 24.04 Docker Image/Container for RasperryPI(arm64v8 CPU Architecture)
#  - Enabeling hardware access like I2C, GPIO and SPI.
#----------------------
# Commands:
#  1) Build Image     tag='kullken/ros2_arm64v8:pet-base-jazzy'
#     Start Container name='pet-base-jazzy_container'
#     $ docker compose up --detach --build 
#
#  2) List running/active/paused containers
#     $ docker compose ps -all
#
#  3)  Connect bash/terminal to existing/new container: 
#      $ docker exec -it pet-base-jazzy_container bash
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
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
#
FROM arm64v8/ros:jazzy-ros-base-noble

ENV DOCKERUSER="pet"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV WS_LOCAL="${HOMEDIR}/ws_ros2-local"
ENV VIRTUAL_ENV="${WS_LOCAL}/venv"
ENV DOCKERPROMPT="Pet-Base-jazzy"

LABEL description="Custom ROS2 jazzy base (Ubuntu 24.04) image for RasperryPI(arm64) with support for hardware access like I2C, GPIO and SPI."
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.0"

SHELL ["/bin/bash", "-c"]

# Setup Docker user "pet" for access to i2c and GPIO
# Support Ubuntu 24.04 using group: dailout,video
# Support RaspianOS using groups:   spi,i2c,gpio, video
# Group 'dialout' => ls -la /dev/gpiomem {Part of the '/dev/mem' that is used for the gpio}
# Group 'dialout' => ls -la /dev/i2c*    {Could be 1 or 2 i2c ports}
# Group 'dialout' => ls -la /dev/spi*
# Group 'dialout' => ls -la /dev/ttyUSB*
# Group 'video'   => ls -la /dev/vchiq

# Remove Ubuntu/Image default user = 1000:1000 with name 'ubuntu'
# Create new user = 1000:1000 with name '${DOCKERUSER}' 
USER root
RUN userdel --remove ubuntu

RUN useradd \
    --uid 1000 \
    --shell /bin/bash \
    --home-dir ${HOMEDIR} \
    --create-home \
    --user-group \
    --groups adm,dialout,sudo,video,audio,plugdev,dip \
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
# Install 'gpiod' GPIO-nice-to-have-tool, including '$ gpioinfo'
# Install 'net-tool' LAN-nice-to-have-tool, including '$ ifconfig'
# Install 'libraspberrypi-bin' vcgencmd tool is used to output information from the VideoCore GPU on the Raspberry Pi. 
# Install 'gpiod'
USER root
RUN apt-get update -y &&\
    apt-get install -y \
        i2c-tools \
        net-tools \
        libraspberrypi-bin \
        gpiod &&\
    rm -rf /var/lib/apt/lists/*

# Install extentions for I2C, GPIO and SPI
# - Note: If possible try find .deb package via '$ apt-get install', instead of using '$ pip3 install',
#         due to risk of introducing dependencies missmatch when using '$ pip3 install'
USER root
RUN apt-get update -y &&\
    apt-get install -y --upgrade python3-setuptools &&\
    apt-get install -y \
        pipx \
        python3-pip \
        python3-lgpio \
        python3-rpi-lgpio \
        python3-smbus2 \
        python3-gpiozero \
        python3-venv &&\
        rm -rf /var/lib/apt/lists/*

# Setup a local ROS2 Workspace in local Docker file system
# USER ${DOCKERUSER}
# RUN mkdir -p ${WS_LOCAL}/src
# RUN cd ${WS_LOCAL}
# RUN /bin/bash -c "source /opt/ros/jazzy/setup.bash; colcon build --symlink-install"
# Setup a Python3 virtual environment in the local ROS2 workspace
# USER ${DOCKERUSER}
# RUN python3 -m venv --system-site-packages ${VIRTUAL_ENV}
# # RUN echo "Colcon (ROS2) should not try to build this directory ($VIRTUAL_ENV)" > ${VIRTUAL_ENV}/COLCON_IGNORE
# # source ./venv/bin/activate
# ENV PATH="${VIRTUAL_ENV}/bin:$PATH"

# Install Python3 extentions/libraries for I2C, GPIO + Drivers for sensors/actuators
USER ${DOCKERUSER}
RUN pip3 install --break-system-packages \
         adafruit-blinka \
         adafruit-circuitpython-ads1x15 \
         adafruit-circuitpython-ina219 \
         adafruit-circuitpython-mpu6050 \
         adafruit-circuitpython-vl53l1x 

# RUN pip3 install \
#         RPi.GPIO \  => sudo apt-get install python3-rpi.gpio
#         Adafruit_ADS1x15 \
#         board \
#         adafruit-blinka \
#         gpio \
#         lgpio \    => sudo apt-get install python3-lgpio
#         pigpio \   => Not needed for now!
#         smbus2 \   => sudo apt-get install python3-smbus2
#         gpiozero \ => sudo apt-get install python3-gpiozero
#         rpi_lcd

# Stuff...
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
RUN echo "Created this file so I do not get the annoying messages 'To run a command as administrator...'" > ~/.sudo_as_admin_successful

# Adding stuff to >> $~/.bashrc
USER ${DOCKERUSER}
RUN echo '# Setting up my own fancy Terminal Prompt :-)'                    >> ${HOMEDIR}/.bashrc &&\
    echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;37;44m\]🐳${DOCKERPROMPT}\[\033[00m\]_\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ "' >> ${HOMEDIR}/.bashrc &&\
    echo '# Setting up alias for sourcing ROS2'                             >> ${HOMEDIR}/.bashrc &&\
    echo "alias jazzy='source /opt/ros/jazzy/setup.bash'"                 >> ${HOMEDIR}/.bashrc &&\
    echo "alias pet_source='source /home/pet/ws_ros2/install/setup.bash'"   >> ${HOMEDIR}/.bashrc

# Setup exit condtions
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]