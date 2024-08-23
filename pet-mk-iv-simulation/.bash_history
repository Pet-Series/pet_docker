source ~/ws_ros1/devel/setup.bash
roslaunch pet_mk_iv_simulation pet_play_yard-01.launch
roslaunch pet_mk_iv_simulation pet_play_yard-02.launch
roslaunch pet_mk_iv_simulation pet_play_yard-02.launch
roslaunch pet_mk_iv_simulation testrun_01_avoid-wall-line-stop.launch
roslaunch pet_mk_iv_simulation spawn_pet_mk_iv.launch
rosrun pet_mk_iv_mission_control testrun_00_line-stop.py
rosrun pet_mk_iv_mission_control testrun_01_avoid-wall-line-stop.py
rosrun pet_mk_iv_mission_control rosrun pet_mk_iv_mission_control 
roslaunch pet_mk_iv_description rviz.launch
rqt_graph
env|grep ROS
env|grep GAZEBO