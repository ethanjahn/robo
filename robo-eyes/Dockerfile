FROM ubuntu:18.04

ENV HOME /home/developer
WORKDIR /home/developer

RUN apt-get update && apt-get install sudo curl wget gnupg software-properties-common -y
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN apt-add-repository https://packages.microsoft.com/ubuntu/18.04/prod
RUN apt-get update -y

# Install the k4a-tools package which has a EULA that needs to interactively be signed
RUN ACCEPT_EULA=Y apt-get install k4a-tools -y

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

COPY --chown=1000:1000 eyes.sh /home/developer/eyes.sh

# Set rules
RUN mkdir /etc/udev/
COPY rules.d /etc/udev/rules.d


USER developer


# To actually use the thing, you need to manually install k4a-tools with `sudo apt install k4a-tools` due to EULA