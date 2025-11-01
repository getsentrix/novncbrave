#!/bin/bash

export DISPLAY=:1

Xvfb :1 -screen 0 1280x720x24 &

x11vnc -display :1 -nopw -forever -shared &

openbox &

dbus-launch brave-browser --no-sandbox --disable-gpu &
  
wait
