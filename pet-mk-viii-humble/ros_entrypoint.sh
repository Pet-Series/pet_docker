#!/bin/bash
# Launch from docker image pet-mk-viii-runtime-humble
set -e
source /home/pet/ws_ros2/install/setup.bash
exec "$@"