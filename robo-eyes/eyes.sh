# wait for roscore to be running
./wait-for-it.sh 127.0.0.1:11311

# source
source /opt/ros/melodic/setup.bash
source /home/developer/catkin_ws/devel/setup.bash

# launch ros driver
roslaunch azure_kinect_ros_driver driver.launch