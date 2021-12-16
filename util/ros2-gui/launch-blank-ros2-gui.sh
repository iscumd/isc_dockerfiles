#!/bin/bash

# This file launches a blank ros2 container with a gui. As this is connected to the host, this container can be used just like you have an actual ros2 enviornment even on *Linux* machines that do not have ros2. This means you can even see other containers running on the host network.

docker run --privileged --rm -v /dev:/dev --net=host --pid=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" -it osrf/ros:foxy-desktop
