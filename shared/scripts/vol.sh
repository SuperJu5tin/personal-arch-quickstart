#!/bin/bash

# Get the current volume and mute status using pactl
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1)
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Display volume and mute status
if [ "$mute" = "yes" ]; then
  echo " "
else
  echo "  $volume"
fi
