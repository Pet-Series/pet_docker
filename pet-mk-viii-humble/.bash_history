source ~/ws_ros1/devel/setup.bash
ros2 launch pet_mk_viii pet-mk-viii-bringup.launch.py
env|grep ROS
env|grep GAZEBO
cd /home/pet/ws_ros2/src/Pet-Mk-VIII/diagnos
vcgencmd measure_temp
vcgencmd measure_clock arm
vcgencmd get_mem arm
vcgencmd get_mem gpu
vcgencmd get_lcd_info
vcgencmd measure_volts core
vcgencmd measure_volts
vcgencmd measure_clock arm