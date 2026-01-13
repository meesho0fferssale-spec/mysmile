#!/bin/bash

# Clean old VNC locks
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

# Start VNC
vncserver :1 -geometry 1280x720 -depth 24

# Start noVNC
cd /noVNC
./utils/launch.sh --vnc localhost:5901 --listen 8900
