#!/bin/bash

# Get memory info in MiB
read total used <<< $(free -m | awk '/^Mem:/ { print $2, $3 }')

# Convert to GB (round to 1 decimal place)
total_gb=$(echo "scale=1; $total / 1024" | bc)
used_gb=$(echo "scale=1; $used / 1024" | bc)

# Emoji for aesthetics
icon=" "

# Output format: icon + used / total
echo "$icon ${used_gb}G / ${total_gb}G"
