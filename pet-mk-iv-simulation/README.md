![License MIT](https://img.shields.io/github/license/Pet-Series/pet_mk_iv_simulation?color=blue)
![ROS version](https://img.shields.io/badge/ROS1-Noetic-brightgreen)

# README: /pet_docker/pet-mk-iv-simulation #

ROS1 repository in the https://github.com/Pet-Series Git-Organizations.</br>

Containing a Pet-Mk.IV ROS1-package / data for Gazebo & RViz
- FROM osrf/ros:noetic-desktop-full-focal (amd64)
   - Ubuntu 20.04.6 LTS (aka. "Focal Fossa")
   - ROS1 Noetic full desktop (aka. "Noetic Ninjemys")

## **What is this folder for?** ##
Docker stuff neccesary to be able to build & run robot simulation of Pet-Mk.IV, using Gazebo.</br>
- https://github.com/Pet-Series/Pet-Mk-IV.git
- https://github.com/Pet-Series/pet_mk_iv_simulation.git
- https://github.com/Pet-Series/pet_docker `<- This Repo.`
- https://hub.docker.com/repository/docker/kullken/ros1_amd64   `<- Look for tag 'pet-mk-iv-simulation'`
<table>
    <tr>
        <td>
            <img src="https://github.com/Pet-Series/Pet-Mk-IV/blob/master/doc/pet_mk_iv-rviz(with_TF).png" width="450px">
        </td>
        <td width="500px">
            This package is only necessary if you are going to launch your robot into a simulated world using Docker.</br>
            </br>
            If you only will run the physical robot - Then you do not need this package.
        </td>
    </tr>
</table>



# Setup
## **How do I set up?** ##
```bash
user@host:~$ docker pull kullken/ros1_amd64:pet-mk-iv-simulation
```
```bash
user@host:~$ xhost local:docker
user@host:~$ docker run \
    -it \
    --rm \
    --network=host \
    --privileged \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --env DISPLAY=${DISPLAY} \
    --name pet-mk-iv-simulation_container \
    kullken/ros1_amd64:pet-mk-iv-simulation
```
```bash
🐳pet@docker:~$ roslaunch pet_mk_iv_simulation testrun_01_avoid-wall-line-stop.launch
```
```bash
user@host:~$ docker exec -it pet-mk-iv-simulation_container bash
```
```bash
🐳pet@docker:~$ roslaunch pet_mk_iv_description rviz.launch
```
