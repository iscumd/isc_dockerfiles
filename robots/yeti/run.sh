#!/bin/bash

# Run while mounting the dev folder, and using the system net stack. 
# Dev is passed to allow for serial port access.
docker run --privileged -v /dev:/dev --net host yeti
