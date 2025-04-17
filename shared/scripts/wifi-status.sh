#!/bin/bash

# Get SSID of the active Wi-Fi connection
ssid=$(nmcli -t -f active,ssid dev wifi | grep "^yes" | cut -d: -f2)

# Define icons and colors
wifi_icon_connected="󰖩"  # Regular Wi-Fi icon
wifi_icon_disconnected="󰖪"  # Wi-Fi with X icon

# Conditional output
if [[ -z "$ssid" ]]; then
    # Not connected
    echo -e "$wifi_icon_disconnected"
else
    # Connected
    echo -e "$wifi_icon_connected $ssid"
fi
