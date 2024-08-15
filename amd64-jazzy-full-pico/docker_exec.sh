#!/bin/bash
# Start bash in existing container (Status Up/Paused).
# More info: https://hub.docker.com/repositories/kullken
 docker exec -it --env HOSTUSER=$USER jazzy-full-pico-container bash