# File: Builds and runs a production version of Yeti

FROM osrf/ros:foxy-desktop

SHELL ["/bin/bash", "-c"]

# Allow for choosing the brach to build on.
ARG branch=ros2
ENV branch ${branch}

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
WORKDIR /home/isc/ros2_ws/

# Clone the Mammoth repo and all dependancies.
RUN vcs import src --input https://raw.githubusercontent.com/iscumd/Mammoth/${branch}/mammoth.repos

USER root

# Copy in fast-dds config to disable shared memory, force UDP communication. This allows for connections with the host.
COPY ./dds-fix.xml ../fastrtps-profile.xml
ENV FASTRTPS_DEFAULT_PROFILES_FILE=/home/isc/fastrtps-profile.xml

RUN rosdep update 
RUN rosdep install --from-paths src --ignore-src -r -y

# Build the repo
RUN source /opt/ros/foxy/setup.bash && \
    colcon build

# Start Yeti!
ENTRYPOINT source /opt/ros/foxy/setup.bash && source ./install/setup.bash && ros2 launch mammoth_snowplow mammoth.launch.py
