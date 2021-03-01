#!/usr/bin/env python
# license removed for brevity

import rospy
import numpy as np
from std_msgs.msg import String, UInt8MultiArray

def talker():
    pub = rospy.Publisher('/joint_array', UInt8MultiArray, queue_size=10)
    rospy.init_node('talker', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        msg = UInt8MultiArray()
        msg.layout = []
        msg.data = [5, 74, 28, 6, 26, 73]
        rospy.loginfo(msg)
        pub.publish(msg)
        rate.sleep()

def callback(data):
    print(data)
    print([ord(i) for i in tuple(data.data)])
    print(data._type)
    #print(data.data)

def listener():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # name are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('listener', anonymous=True)

    rospy.Subscriber("/joint_array", UInt8MultiArray, callback)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    try:
        #listener()
        talker()
    except rospy.ROSInterruptException:
        pass