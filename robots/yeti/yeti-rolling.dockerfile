# File: Builds and runs a develupment version of yeti based off of a repo mounted at /home/isc/ros2_ws/

FROM osrf/ros:foxy-desktop

SHELL ["/bin/bash", "-c"]

# Make root's password 1234
RUN echo 'root:1234' | chpasswd

# Create a non root user with a password of 1234
RUN useradd --create-home --shell /bin/bash isc -p 1234 
RUN echo 'isc:1234' | chpasswd 
RUN adduser isc sudo

# install tools
RUN sudo apt-get update && sudo apt-get install git wget python3-vcstool curl -y

# Install system deps
RUN sudo apt-get update && sudo apt-get install libgflags-dev ros-foxy-ros2-ouster ros-foxy-realsense2-camera  ros-foxy-joint-state-publisher -y 

# Source setup file
USER isc
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc

# Move into workspace
RUN mkdir -p /home/isc/ros2_ws/src 
# The code will be mounted here
WORKDIR /home/isc/ros2_ws/

USER root
RUN rosdep update 

# Start Yeti, after building from the mounted code.
ENTRYPOINT source /opt/ros/foxy/setup.bash && \
     rosdep install --from-paths src --ignore-src -r -y && \
     colcon build && \
     source ./install/setup.bash && \
     ros2 launch mammoth_snowplow mammoth.launch.py
