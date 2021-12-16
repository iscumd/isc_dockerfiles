Rolling builds a local Yeti workspace on each run, allowing for active development without needing to rebuild the container on each change. Plain Yeti is the production image that bakes the yeti code into the image, preventing unwanted changes from occurring in production and launching without needing to rebuild the code.

See the upper level readme for more details.

# ROS2 oddities

In each of these scripts, we connect the docker container to the host's ip stack by using `net=host` and run all processes in the container in the hosts PID space using `pid=host`. Now these two should be enough to see the container's processes from the host and other containers (using ros2's host discovery), but unfortunatly a quirk in Fast-DDS currently makes this a bit harder. Fast-DDS switches to using shared memory when it detects multiple ros2 instances running on the same machine. This makes sense for a local machine, but if one is using containers, then each container uses it's own copy of the shared memory and never actually passes anything. The fix for this is to pass the /dev/ directory into the container as a volume mount, allowing for the shared memory to be, well, shared. 

If this stratagy appears to not work for connecting the host to the container for some reason, there also exits [an XML file that you can use to disable this shared memory use altogether.](https://answers.ros.org/question/370595/ros2-foxy-nodes-cant-communicate-through-docker-container-border/).
