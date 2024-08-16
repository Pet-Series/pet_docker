![License MIT](https://img.shields.io/github/license/Pet-Series/pet_docker?color=blue&style=plastic)
![ROS version](https://img.shields.io/badge/ROS2-Jazzy-brightgreen?style=plastic)
![Ubuntu version](https://img.shields.io/badge/Ubuntu-24.04-green?style=plastic)

# README: /pet_docker/amd64-jazzy #

  - ROS2-docker repository in the https://github.com/Pet-Series Git-Organizations.</br>

  - FROM osrf/ros:jazzy-desktop-full-noble (amd64)
    - Ubuntu 24.04 LTS (aka. "Nobel")
    - ROS2 Jazzy LTS (full desktop)
      https://docs.ros.org/en/jazzy/

# Tutorial/tests in this folder
  In this exampels we only using prebuilt Docker Images from Ubuntu and OSRF.
  
  ## docker_run.sh
  Launch a plain ROS2 Jazzy full desktop (based on Ubuntu 24.04 LTS)
  - What...
  - ...
  ```bash 
  kullken@yoda:~$ cd ~/ws_ros2/src/pet_docker/amd64-jazzy
  kullken@yoda:~/ws_ros2/src/pet_docker/amd64-jazzy$ ./docker_run.sh
  ...
  kullken@yoda:~/ws_ros2/src/pet_docker/amd64-jazzy$ 
  ```
  
  ```bash
  kullken@yoda:~$ docker exec -it ubuntu-nobel-container bash
  ...
  kullken@yoda:~$ 
  
  ```
  
  ## docker-compose_jazzy-desktop-full-noble.yml
  Launch a plain ROS2 Jazzy full desktop (based on Ubuntu 24.04 LTS)
  - What...
  - ...
  ```bash 
  kullken@yoda:~$ cd ~/ws_ros2/src/pet_docker/amd64-jazzy
  kullken@yoda:~/ws_ros2/src/pet_docker/amd64-jazzy$ docker compose --file docker-compose_jazzy-desktop-full-noble.yml up --detach
  ...
  kullken@yoda:~/ws_ros2/src/pet_docker/amd64-jazzy$ 
  ```

  ```bash
  kullken@yoda:~$ docker exec -it ubuntu-nobel-container bash
  ...
  kullken@yoda:~$ 
  
  ```

  ## docker-compose_noble.yml
  Launch a plain Ubuntu 24.04 LTS
  - What...
  - ...
  ```bash 
  kullken@yoda:~$ cd ~/ws_ros2/src/pet_docker/amd64-jazzy
  kullken@yoda:~/ws_ros2/src/pet_docker/amd64-jazzy$ docker compose --file docker-compose_noble.yml up --detach
  ...
  kullken@yoda:~/ws_ros2/src/pet_docker/amd64-jazzy$ 
  ```

  ```bash
  kullken@yoda:~$ docker exec -it ubuntu-nobel-container bash
  ...
  kullken@yoda:~$ 
  
  ```

  ## docker-compose_ROS2talker-listener.yml
  Launch the ROS2 demo_node 'talker' and 'listener'
  - What...
  - ...
  ```bash 
  kullken@yoda:~$ cd ~/ws_ros2/src/pet_docker/amd64-jazzy
  kullken@yoda:~/ws_ros2/src/pet_docker/amd64-jazzy$ docker compose --file docker-compose_ROS2talker-listener.yml up --detach
  ...
  kullken@yoda:~/ws_ros2/src/pet_docker/amd64-jazzy$ 
  ```

  ```bash
  kullken@yoda:~$ docker exec -it ubuntu-nobel-container bash
  ...
  kullken@yoda:~$ 
  
  ```