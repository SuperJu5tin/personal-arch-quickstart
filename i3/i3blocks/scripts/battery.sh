#!/bin/bash

# Get battery info from acpi (first line used for status, all lines for percentage)
battery_info=$(acpi -b)

# Extract and average percentages for multiple batteries
percentage=$(echo "$battery_info" | awk -F', ' '{gsub("%","",$2); sum+=$2} END {printf "%.0f", sum/NR}')

# Extract charging status from the first battery line
status=$(echo "$battery_info" | head -n1 | awk '{print $3}' | tr -d ',')

# Icons
charging_icon="󰂄 "
discharging_icon="󰂁 "
low_battery_icon="󰂃 "

# Pick icon
if [[ "$status" == "Charging" ]]; then
	icon=$charging_icon
elif [[ "$percentage" -lt 20 ]]; then
	icon=$low_battery_icon
else
	icon=$discharging_icon
fi

# Bar logic
total_bars=10
filled_bars=$((percentage / 10))
bar="["
for i in $(seq 1 $total_bars); do
	if [[ $i -le $filled_bars ]]; then
		bar+="|"
	else
		bar+="·"
	fi
done
bar+="]"

# Color logic
if [[ "$status" == "Charging" ]]; then
	color="#00FF00"  # green
elif [[ "$percentage" -lt 20 ]]; then
	color="#FF0000"  # red
elif [[ "$percentage" -lt 50 ]]; then
	color="#FFFF00"  # yellow
else
	color="#00FFAA"  # cyan
fi

# Output for i3blocks (full text, short text, color)
echo "$icon $percentage% $bar"
echo
echo "$color"
echo "#000000"

