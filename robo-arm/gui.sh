#!/usr/bin/env bash
./wait-for-it.sh 127.0.0.1:11311
arduino &
cd catkin_ws
source devel/setup.bash
cd src/braccio_arduino_ros_rviz
roslaunch braccio_arduino_ros_rviz urdf.launch model:=urdf/braccio_arm.urdf