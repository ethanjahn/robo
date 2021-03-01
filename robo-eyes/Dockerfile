FROM osrf/ros:melodic-desktop-full

ENV HOME /home/developer
WORKDIR /home/developer

# Update apt
RUN apt-get update -y

# Create catkin workspace and clone braccio_arduino_ros_rviz
RUN apt-get install ros-melodic-catkin python-catkin-tools -y
RUN [ \
    "/bin/bash", \
    "-c", \
    "source /opt/ros/melodic/setup.bash; \
    mkdir -p ~/catkin_ws/src; \
    cd ~/catkin_ws/src; \
    catkin_init_workspace; \
    cd ~/catkin_ws; \
    catkin_make; \
    cd ~" \
]

# Install azure kinect tools
RUN apt-get install sudo curl wget gnupg software-properties-common -y
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN apt-add-repository https://packages.microsoft.com/ubuntu/18.04/prod

# Install the k4a-tools package which has a EULA that needs to interactively be signed
RUN ACCEPT_EULA=Y apt-get install k4a-tools libk4a1.4-dev -y

# Install the kinect ROS driver
RUN [ \
    "/bin/bash", \
    "-c", \
    "source /opt/ros/melodic/setup.bash; \
    cd ~/catkin_ws/src; \
    git clone https://github.com/microsoft/Azure_Kinect_ROS_Driver.git; \
    cd ~/catkin_ws; \
    catkin_make; \
    cd ~" \
]

COPY custom.launch /home/developer/catkin_ws/src/Azure_Kinect_ROS_Driver/launch/custom.launch

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    mkdir -p /etc/sudoers.d && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

# Add developer user to the dialout group to be ale to write the serial USB device
RUN sed "s/^dialout.*/&developer/" /etc/group -i \
    && sed "s/^root.*/&developer/" /etc/group -i

# Make user sudoer
RUN useradd -m docker && echo "developer:developer" | chpasswd && adduser developer sudo

COPY --chown=1000:1000 eyes.sh /home/developer/eyes.sh

# Add ros setup to .bashrc
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
RUN echo "source /home/developer/catkin_ws/devel/setup.bash" >> ~/.bashrc


# Set rules
RUN mkdir /etc/udev/
COPY rules.d /etc/udev/rules.d

# Copy in shell files
COPY --chown=1000:1000 wait-for-it.sh /home/developer/wait-for-it.sh
COPY --chown=1000:1000 eyes.sh /home/developer/gui.sh


USER developer
