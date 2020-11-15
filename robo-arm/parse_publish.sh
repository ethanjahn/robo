#!/usr/bin/env bash
./wait-for-it.sh 127.0.0.1:11311
cd catkin_ws
source devel/setup.bash
cd src/braccio_arduino_ros_rviz
rosrun braccio_arduino_ros_rviz parse_and_publish __name:=parse_node