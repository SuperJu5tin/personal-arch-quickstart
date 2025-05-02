#!/bin/bash

DMENU_FONT="JetBrainsMono-18"
PIDFILE="/tmp/screen_recording.pid"

# If PID file exists and process is running: stop recording
if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill "$(cat "$PIDFILE")"
    rm "$PIDFILE"
    notify-send "🎬 Screen recording stopped"
    exit 0
fi

# Ask for recording name
name=$(dmenu -fn "$DMENU_FONT" -p "Recording name:" < /dev/null)
[ -z "$name" ] && notify-send "Recording cancelled" && exit 1

# Ensure Videos directory exists
mkdir -p "$HOME/Videos"
outfile="$HOME/Videos/${name}.mp4"

# Check if file exists
if [ -e "$outfile" ]; then
    choice=$(printf "Overwrite\nChoose new name\nCancel" | dmenu -fn "$DMENU_FONT" -p "File exists. What now?" < /dev/null)
    case "$choice" in
        "Overwrite")
            ;;
        "Choose new name")
            name=$(dmenu -fn "$DMENU_FONT" -p "New recording name:" < /dev/null)
            [ -z "$name" ] && notify-send "Recording cancelled" && exit 1
            outfile="$HOME/Videos/${name}.mp4"
            ;;
        *)
            notify-send "Recording cancelled"
            exit 1
            ;;
    esac
fi

# Start ffmpeg in background and save PID
ffmpeg \
-f x11grab -framerate 30 -i :0.0 \
-f pulse -i default \
-c:v libx264 -preset veryfast -crf 23 \
-c:a aac -b:a 128k \
"$outfile" > /dev/null 2>&1 &

echo $! > "$PIDFILE"
notify-send "🔴 Recording started: $name"

