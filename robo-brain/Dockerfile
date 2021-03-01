FROM osrf/ros:melodic-desktop-full

ENV HOME /home/developer
WORKDIR /home/developer

# Add ros setup to .bashrc
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

# Copy in shell files
COPY wait-for-it.sh /home/developer/wait-for-it.sh
COPY publisher.py /home/developer/publisher.py
