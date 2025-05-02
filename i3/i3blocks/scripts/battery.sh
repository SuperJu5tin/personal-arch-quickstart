#!/bin/bash

# Get battery percentage and status
battery_info=$(acpi -b)
percentage=$(echo "$battery_info" | awk -F', ' '{print $2}' | tr -d '%')
status=$(echo "$battery_info" | awk '{print $3}' | tr -d ',')

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
	color="#00FFAA"  # white
fi

# Output for i3blocks (text, short text, color)
echo "$icon $percentage% $bar"
echo
echo "$color"

