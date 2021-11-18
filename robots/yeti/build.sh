#!/bin/bash

# Create kernal rule that allows for device passthrough
touch /etc/udev/rules.d/99-serial.rules
/etc/udev/rules.d/99-serial.rules < KERNEL=="ttyUSB[0-9]*",MODE="0666"

# Build the file with name yeti
docker build -t yeti:latest -f yeti.dockerfile