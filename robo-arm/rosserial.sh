#!/usr/bin/env bash
./wait-for-it.sh 127.0.0.1:11311
rosrun rosserial_python serial_node.py /dev/ttyACM0 __name:=ros_serial