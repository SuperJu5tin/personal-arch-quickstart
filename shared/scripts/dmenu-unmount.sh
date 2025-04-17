#!/bin/bash

# List all mounted devices using lsblk
device=$(lsblk -rpo "NAME,SIZE,MOUNTPOINT" | awk '$3 != "" {print $1 " (" $2 ") - Mounted at " $3}' | dmenu -fn "monospace-18" -i -p "Select drive to unmount:")

# Exit if no device is selected
[ -z "$device" ] && exit 1

# Extract the device path (e.g., /dev/sda1)
device_path=$(echo $device | awk '{print $1}')

# Ensure the device path is correct by printing it
echo "Device selected: $device_path"

# Check if the device is mounted (using mount to confirm)
if ! mount | grep -q "^$device_path "; then
    notify-send "Device is not mounted."
    exit 0
fi

# Attempt to unmount using udisksctl
if udisksctl unmount -b "$device_path"; then
    notify-send "Successfully unmounted $device_path"
else
    notify-send "Failed to unmount $device_path"
fi
