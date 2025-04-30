#!/bin/bash

# Set DISPLAY environment variable if not already set
export DISPLAY=:0

# List all unmounted partitions using lsblk and dmenu
device=$(lsblk -rpo "NAME,SIZE,MOUNTPOINT" | awk '$3 == "" && $1 ~ /[0-9]+$/ {print $1 " (" $2 ")"}' | dmenu -fn "monospace-18" -i -p "Select drive to mount:")

# Exit if no device is selected
[ -z "$device" ] && exit 1

# Extract the device path (e.g., /dev/sda1)
device_path=$(echo "$device" | awk '{print $1}')

# Attempt to mount using udisksctl
if udisksctl mount -b "$device_path"; then
    notify-send "Successfully mounted $device_path"
else
    notify-send "Failed to mount $device_path"
fi
