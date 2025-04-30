#!/bin/bash

# Get the current power profile
current_profile=$(powerprofilesctl get)

# Define power profile options
profiles="Balanced\nPower Saving\nHigh Performance"

# Show the current profile in the dmenu prompt with a specified font size
selected_profile=$(echo -e "$profiles" | dmenu -p "Current: $current_profile - Select Power Profile:" -fn "Monospace-18")

# Apply the selected profile using power-profiles-daemon
case "$selected_profile" in
    "Power Saving")
        powerprofilesctl set power-saver
        ;;
    "High Performance")
        powerprofilesctl set performance
        ;;
    "Balanced")
        powerprofilesctl set balanced
        ;;
    *)
        echo "Invalid selection!"
        ;;
esac


# Send signal 30 to i3blocks to trigger an update
pkill -SIGRTMIN+30 i3blocks
