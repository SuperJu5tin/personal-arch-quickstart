#!/bin/bash

PID_FILE=~/ffmpeg_pid.txt
MONITOR_SOURCE="alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__Speaker__sink.monitor"
SAVE_DIR=~/Videos
DMENU_FONT="monospace-18"

if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" > /dev/null 2>&1; then
    notify-send "🎥 Screen Recording" "Stopped"
    pkill -SIGINT ffmpeg
    rm "$PID_FILE"
else
    # Ask for filename using dmenu with larger font
    FILENAME=$(echo "" | dmenu -fn "$DMENU_FONT" -p "Recording filename:")

    # Use timestamp if empty
    if [ -z "$FILENAME" ]; then
        FILENAME="recording_$(date +%Y%m%d_%H%M%S)"
    fi

    OUTPUT="$SAVE_DIR/$FILENAME.mp4"
    notify-send "🎥 Screen Recording" "Started: $FILENAME.mp4"

    ffmpeg \
        -f x11grab -video_size 2880x1800 -i :0.0 \
        -f pulse -i "$MONITOR_SOURCE" \
        -c:v libx264 -preset ultrafast -crf 18 \
        -c:a aac -strict experimental \
        "$OUTPUT" &
    echo $! > "$PID_FILE"
fi

