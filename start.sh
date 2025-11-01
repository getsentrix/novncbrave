#!/bin/bash
set -e

# Start base services (VNC, KasmVNC, etc.)
/init

# Launch Brave in the background
export DISPLAY=:1
brave-browser --no-sandbox --disable-gpu &

# Keep container running
wait
