source /home/pet/ws_ros2/install/setup.bash
source /opt/ros/jazzy/setup.bash
source ~/venv/bin/activate
ros2 run pet_ros2_joystick_pkg pet_joystick_node
ros2 launch pet_mk_viii pet-mk-viii-bringup.launch.py
cd ~/ws_ros2 && colcon build --symlink-install
colcon list
colcon graph
env|grep ROS
env|grep GAZEBO
cd /home/pet/ws_ros2/src/pet_docker/arm64-pet-jazzy
cd /home/pet/ws_ros2/src/pet_docker/pet-mk-viii-jazzy
cd /home/pet/ws_ros2/src/Pet-Mk-VIII/diagnos
vcgencmd measure_temp
vcgencmd measure_clock arm
vcgencmd get_mem arm
vcgencmd get_mem gpu
vcgencmd get_lcd_info
vcgencmd measure_volts core
vcgencmd measure_volts
vcgencmd measure_clock arm
i2cdetect -y 1