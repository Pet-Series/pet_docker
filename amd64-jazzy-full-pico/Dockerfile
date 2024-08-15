# Dockerfile: Add on layer for ROS2/Jazzy with extensitons for ROS Micro-ROS and Rasperry Pi Pico 1/2
# - AMD64/x86 CPU Architecture
# - ROS Version: ROS2 2024    LTS(amd64) aka."Jazzy"
# - OS version : Ubuntu 24.04 LTS(amd64) aka."noble"
#----------------------
# Maintainer: stefan.kull@gmail.com
# Licens: MIT
# https://github.com/Pet-Series
# https://hub.docker.com/u/kullken

# Build this Docker image with:
#----------------------
# $ docker build --tag kullken/ros2_amd64:jazzy-full-pico .

# Launch this Docker image with:
#----------------------
# $ docker run -it --network=host --privileged kullken/ros2_amd64:jazzy-full-pico

# Commands for running the example
#----------------------
# $ docker run -it --rm --volume /media:/media --volume /home/$USER/ws_ros2:/home/ubuntu/ws_ros2 --device=/dev/ttyACM0 kullken/ros2_amd64:jazzy-full-pico
# $ ros2 run micro_ros_agent micro_ros_agent serial --dev /dev/ttyACM0 baudrate=115200
#----------------------

# Some usefull links to source/original...
# - https://github.com/micro-ROS/micro_ros_setup
# - https://hub.docker.com/_/ros/
# - https://hub.docker.com/r/osrf/ros/tags?name=jazzy

#Maybe some useful links to your custom content...
# - https://github.com/Pet-Series/pet_docker
# - https://hub.docker.com/r/kullken/
# - https://hub.docker.com/repository/docker/kullken/ros2_amd64


FROM kullken/ros2_amd64:jazzy-full

ENV DOCKERUSER="ubuntu"
ENV HOMEDIR="/home/${DOCKERUSER}"
ENV DOCKERPROMPT="Jazzy-full-pico"

LABEL description="ROS2 Jazzy Micro-ROS for RPi Pico image for PC with AMD64/x486"
LABEL maintainer="Stefan Kull <stefan.kull@gmail.com>"
LABEL version="1.0"

SHELL ["/bin/bash", "-c"]

# Configure Pico SDK environment
ENV PICO_TOOLCHAIN_PATH=/usr/bin/arm-none-eabi-gcc
ENV PICO_EXAMPLES=${HOMEDIR}/pico/pico-examples
ENV PICO_SDK_PATH=${HOMEDIR}/pico/pico-sdk
RUN echo "# Configure Pico SDK environment"                      >> ~/.bashrc
RUN echo "export PICO_SDK_PATH=${HOMEDIR}/pico/pico-sdk"         >> ~/.bashrc
RUN echo "export PICO_EXAMPLES=${HOMEDIR}/pico/pico-examples"    >> ~/.bashrc
RUN echo "export PICO_TOOLCHAIN_PATH=/usr/bin/arm-none-eabi-gcc" >> ~/.bashrc
RUN echo "# Configure Pico SDK environment"                      >> ~/.bashrc
RUN echo "echo 'Hopefully🤭 will the RPi Pico appear as /media/'\${HOSTUSER}'/RPI-RP2'" >> ~/.bashrc

# Install needed Ubuntu/Linux packages used by Pico SDK
USER root
RUN apt update && apt install --yes cmake g++ gcc-arm-none-eabi doxygen libnewlib-arm-none-eabi git python3

# Install Pico SDK
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}/pico
RUN git clone --recurse-submodules https://github.com/raspberrypi/pico-sdk.git --branch master \
 && cd ${HOMEDIR}/pico/pico-sdk && git submodule update --init

# Install & build Picotool from source
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}/pico
RUN git clone https://github.com/raspberrypi/picotool.git --branch master

WORKDIR ${HOMEDIR}/pico/picotool/build
RUN cmake .. && make

# Install Pico Exampels
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}/pico/
RUN git clone https://github.com/raspberrypi/pico-examples.git --branch master

# Install Pico micro-ROS SDK from source
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}/ws_micro-ros/src
RUN git clone https://github.com/micro-ROS/micro_ros_raspberrypi_pico_sdk.git --branch ${ROS_DISTRO}
# Update dependencies for workspace ${HOMEDIR}/ws_micro-ros/ using '$ rosdep'
USER root
WORKDIR ${HOMEDIR}/ws_micro-ros
RUN apt update
# RUN rosdep init
USER ${DOCKERUSER}
RUN rosdep update
RUN rosdep install -y --from-paths ${HOMEDIR}/ws_micro-ros/src --ignore-src
# Build Pico micro-ROS SDK from source
WORKDIR ${HOMEDIR}/ws_micro-ros/src/micro_ros_raspberrypi_pico_sdk/build
RUN cmake .. && make

# Install & Build micro-ROS agent from source
USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}/ws_micro-ros/src
RUN git clone https://github.com/micro-ROS/micro-ROS-Agent.git --branch ${ROS_DISTRO}
RUN git clone https://github.com/micro-ROS/micro_ros_msgs.git  --branch ${ROS_DISTRO}

WORKDIR ${HOMEDIR}/ws_micro-ros 
RUN source /opt/ros/jazzy/setup.bash && \
    colcon build --packages-up-to micro_ros_agent
RUN echo "source ${HOMEDIR}/ws_micro-ros/install/setup.bash" >> ${HOMEDIR}/.bashrc

# Make an RP2040 in BOOTSEL mode writable by all users, so you can `picotool` without `sudo`
USER root
WORKDIR /etc/udev/rules.d
RUN touch /etc/udev/rules.d/99-pictool.rules
RUN echo '# /etc/udev/rules.d/99-pictool.rules'                                                                            >> /etc/udev/rules.d/99-pictool.rules
RUN echo '# [Original source: ~/pico/picotool/udev/*]'                                                                     >> /etc/udev/rules.d/99-pictool.rules
RUN echo '#'                                                                                                               >> /etc/udev/rules.d/99-pictool.rules
RUN echo '# Make an RP2040 in BOOTSEL mode writable by all users, so you can `picotool` without `sudo`'                    >> /etc/udev/rules.d/99-pictool.rules
RUN echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", TAG+="uaccess" MODE="660", GROUP="plugdev"' >> /etc/udev/rules.d/99-pictool.rules
RUN echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0009", TAG+="uaccess" MODE="660", GROUP="plugdev"' >> /etc/udev/rules.d/99-pictool.rules
RUN echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000a", TAG+="uaccess" MODE="660", GROUP="plugdev"' >> /etc/udev/rules.d/99-pictool.rules
RUN echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000f", TAG+="uaccess" MODE="660", GROUP="plugdev"' >> /etc/udev/rules.d/99-pictool.rules
RUN echo '#'                                                                                                >> /etc/udev/rules.d/99-pictool.rules
RUN echo '# Enable RP2040 to run `$ mpr connect $(realpath /dev/pico)`'                                     >> /etc/udev/rules.d/99-pictool.rules
RUN echo '# Symlink an RP2040 running MicroPython from /dev/pico.'                                          >> /etc/udev/rules.d/99-pictool.rules
RUN echo 'SUBSYSTEM=="tty", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0005", SYMLINK+="pico"'             >> /etc/udev/rules.d/99-pictool.rules
RUN echo '#'                                                                                                >> /etc/udev/rules.d/99-pictool.rules
RUN echo '# Enable RP2040 to be recognised by pico-debug'                                                   >> /etc/udev/rules.d/99-pictool.rules
RUN echo 'ATTRS{product}=="*CMSIS-DAP*", MODE="664", GROUP="plugdev"'                                       >> /etc/udev/rules.d/99-pictool.rules

USER ${DOCKERUSER}
WORKDIR ${HOMEDIR}
# Setup exit condtions
# CMD ["/bin/bash"]
# ENTRYPOINT ["/bin/bash", "-c"]