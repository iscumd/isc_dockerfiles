
FROM osrf/ros:foxy-desktop

SHELL ["/bin/bash", "-c"]

# Make root's password 1234
RUN echo 'root:1234' | chpasswd

# Create a non root user with a password of 1234
RUN useradd --create-home --shell /bin/bash isc -p 1234 
RUN echo 'isc:1234' | chpasswd 
RUN adduser isc sudo

# Install tools, then system dependancies
RUN sudo apt-get update && sudo apt-get install git wget python3-vcstool curl -y
RUN sudo apt-get install libgflags-dev -y

# Source setup file
USER isc
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc

# Move into workspace
RUN mkdir /home/isc/workspace/src -p
WORKDIR /home/isc/workspace/

# Clone the Mammoth repo and all dependancies. TODO we can add an ARG to change the branch by using that arg in the following URL.
RUN vcs import src --input https://raw.githubusercontent.com/iscumd/Mammoth/ros2/mammoth.repos

USER root
#TODO fails to install gazebo
RUN rosdep update 
RUN rosdep install --from-paths src --ignore-src -r -y

USER isc

RUN colcon build && \ 
    ./install/setup.bash 
