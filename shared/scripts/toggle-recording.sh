#!/bin/bash

# Define the ffmpeg process ID file
PID_FILE=~/ffmpeg_pid.txt

# Check if ffmpeg is running by checking the PID file
if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") > /dev/null 2>&1; then
    # If ffmpeg is running, stop the recording (gracefully stop ffmpeg)
    notify-send "Stop Recording"
    pkill -SIGINT ffmpeg
    rm "$PID_FILE"  # Remove the PID file after stopping
else
    # If ffmpeg is not running, start a new recording
    notify-send "Starting Recording"
    ffmpeg -f x11grab -s 2880x1800 -i :0.0 -f pulse -i default -f pulse -i default.monitor -c:v libx264 -preset ultrafast -crf 18 -c:a aac -strict experimental ~/Videos/recording_$(date +%Y%m%d_%H%M%S).mp4 &
    echo $! > "$PID_FILE"  # Store the PID of ffmpeg process
fi
