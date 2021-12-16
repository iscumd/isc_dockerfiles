Rolling builds a local Yeti workspace on each run, allowing for active development without needing to rebuild the container on each change. Plain Yeti is the production image that bakes the yeti code into the image, preventing unwanted changes from occurring in production and launching without needing to rebuild the code.

See the upper level readme for more details.

# ROS2 oddities

In each of these scripts, we connect the docker container to the host's ip stack by using `net=host`. Now this should be enough to see the container's processes from the host and other containers (using ros2's host discovery), but unfortunately a quirk in Fast-DDS currently makes this a bit harder. Fast-DDS switches to using shared memory when it detects multiple ros2 instances running on the same machine. This makes sense for a local machine, but if one is using containers, then each container uses it's own copy of the shared memory and never actually passes anything. The fix for this is to pass an XML config into the docker container to disable this behavior. For more info, check out this post [here](https://answers.ros.org/question/370595/ros2-foxy-nodes-cant-communicate-through-docker-container-border/).
