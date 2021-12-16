#!/bin/bash

# Run while mounting the dev folder, and using the system net stack. 
# Dev is passed to allow for serial port access, but it must also be passed 
# to account for a bug in Fast-DDS where you need to pass shared memory in.
docker run --privileged -v /dev:/dev --net host --pid host yeti
