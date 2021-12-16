#!/bin/bash

if [ -n "$1" ]; then
    # Run while mounting the dev folder, and using the system net stack. 
    docker run --privileged -v /dev:/dev -v "$1":/home/isc/ros2_ws --net host yeti:rolling
else
    echo "Please pass a path to your yeti workspace!"
fi 
