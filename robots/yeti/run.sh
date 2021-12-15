#!/bin/bash

# Run while mounting the dev folder, and using the system net stack. 
docker run --privileged -v /dev:/dev --net host --pid host yeti
