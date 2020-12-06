FROM osrf/ros:melodic-desktop-full

ENV HOME /home/developer
WORKDIR /home/developer

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    mkdir -p /etc/sudoers.d && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer && \
    apt-get update \
	&& apt-get install -y \
        software-properties-common \
		wget \
		openjdk-11-jre \
		xvfb \
        xz-utils \
	sudo \
    && add-apt-repository ppa:ubuntuhandbook1/apps \
    && apt-get update \
    && apt-get install -y avrdude avrdude-doc \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Add developer user to the dialout group to be ale to write the serial USB device
RUN sed "s/^dialout.*/&developer/" /etc/group -i \
    && sed "s/^root.*/&developer/" /etc/group -i

ENV ARDUINO_IDE_VERSION 1.8.13

# Download rosserial & wait-for-it
RUN apt-get update && apt-get install -y \
    ros-melodic-rosserial-arduino \
    ros-melodic-rosserial \
    ros-melodic-joint-state-publisher-gui

RUN apt-get update && apt-get upgrade -y

RUN [ \
    "/bin/bash", \
    "-c", \
    "source /opt/ros/melodic/setup.bash; \
    wget -q -O- https://downloads.arduino.cc/arduino-${ARDUINO_IDE_VERSION}-linux64.tar.xz | tar xJC  /usr/local/share; \
    ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION} /usr/local/share/arduino; \
    ln -s /usr/local/share/arduino-${ARDUINO_IDE_VERSION}/arduino /usr/local/bin/arduino; \
    mkdir /home/developer/Arduino; \
    mkdir /home/developer/Arduino/libraries; \
    cd /home/developer/Arduino/libraries/; \
    rm -rf ros_lib; \
    rosrun rosserial_arduino make_libraries.py .; \
    cd /home/developer" \
]

# Copy in the braccio_arduino_ros_rviz
RUN mkdir -p ~/catkin_ws/src
COPY ./braccio_arduino_ros_rviz ~/catkin_ws/src/braccio_arduino_ros_rviz

# Create catkin workspace and clone braccio_arduino_ros_rviz
RUN [ \
    "/bin/bash", \
    "-c", \
    "source /opt/ros/melodic/setup.bash; \
    cd ~/catkin_ws; \
    catkin_make; \
    cp -R ~/catkin_ws/src/braccio_arduino_ros_rviz/libraries/BraccioLibRos ~/Arduino/libraries" \
]


# Add ros setup to .bashrc
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

ENV DISPLAY :1.0

# Make user sudoer
RUN useradd -m docker && echo "developer:developer" | chpasswd && adduser developer sudo

# Copy in shell files
COPY --chown=1000:1000 gui.sh /home/developer/gui.sh
COPY --chown=1000:1000 parse_publish.sh /home/developer/parse_publish.sh
COPY --chown=1000:1000 rosserial.sh /home/developer/rosserial.sh
COPY --chown=1000:1000 wait-for-it.sh /home/developer/wait-for-it.sh

USER developer