#!/bin/bash

# Get brightness percentage using brightnessctl
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percentage=$(( 100 * brightness / max_brightness ))

# Icons
brightness_icon="󰃠 "

# Bar configuration
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
echo "$brightness_icon ${percentage}% $bar"

