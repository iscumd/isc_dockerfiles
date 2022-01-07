#!/bin/bash

# Create kernal rule that allows for device passthrough
sudo touch /etc/udev/rules.d/99-serial.rules
sudo echo "KERNEL==/dev/ttyUSB[0-9]*",MODE="0666" > /etc/udev/rules.d/99-serial.rules 

# Build the file with name yeti
docker build . -t yeti:rolling -f yeti-rolling.dockerfile