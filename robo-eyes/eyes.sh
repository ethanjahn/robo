# wait for roscore to be running
./wait-for-it.sh 127.0.0.1:11311

# source
source /opt/ros/melodic/setup.bash
source /home/developer/catkin_ws/devel/setup.bash

# set parameters
rosparam set /azure_kinect_ros_driver/depth_enabled false
rosparam set /azure_kinect_ros_driver/fps 30
rosparam set /azure_kinect_ros_driver/point_cloud false

# launch ros driver
roslaunch azure_kinect_ros_driver custom.launch