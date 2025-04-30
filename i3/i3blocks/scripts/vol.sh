#!/bin/bash

# Get volume and mute status
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | head -n1 | tr -d '%')
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Icons
mute_icon=" "
volume_icon=" "

# Create bar
total_bars=10
filled_bars=$((volume / 10))
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
if [ "$mute" = "yes" ]; then
    echo "$mute_icon [ MUTED ]"
else
    echo "$volume_icon ${volume}% $bar"
fi

