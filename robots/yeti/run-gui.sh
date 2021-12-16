#!/bin/bash

# This file runs yeti while passing through any gui nodes to the host. This should work fine, but will use extra resources.

# This: 1) mounts all devices through dev. This also passes shared memory, needed if we are using FAST-DDS. 
# 2) connects this docker container to the host networking and pid space. This should allow for direct IP connections to LiDAR
# 3) passes the current display
# 4) mounts the X-server UNIX pipe. This is what actually passes the gui to the host.
docker run --privileged -v /dev:/dev --net=host --pid=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" yeti
