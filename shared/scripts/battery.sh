#!/bin/bash

# Get the battery percentage and charging status
battery_info=$(acpi -b)
percentage=$(echo $battery_info | awk -F', ' '{print $2}' | sed 's/%//')
status=$(echo $battery_info | awk '{print $3}' | sed 's/,//')

# Define icons
charging_icon="󰂄"   # Charging icon
discharging_icon="󰂁" # Discharging icon
low_battery_icon="󰂃" # Low battery icon (below 20%)

# Determine the appropriate icon
if [[ "$percentage" -lt 20 ]]; then
    icon=$low_battery_icon
elif [[ "$status" == "Charging" ]]; then
    icon=$charging_icon
else
    icon=$discharging_icon
fi

# Output the icon with the battery percentage
echo "$icon $percentage%"
