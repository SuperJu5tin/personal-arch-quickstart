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
		bar+="·"  # ghost bar
	fi
done

bar+="]"

# Output
echo "$icon $percentage% $bar"

