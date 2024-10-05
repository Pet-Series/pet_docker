#!/bin/bash
# Launch from docker image pet-mk-viii-runtime
set -e
source /home/pet/ws_ros2-galactic/install/setup.bash
exec "$@"