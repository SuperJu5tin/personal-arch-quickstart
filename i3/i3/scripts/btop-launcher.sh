#!/bin/bash

# Desired font size and font family for xterm
font="Monospace"
font_size=16

# Check if the window with the title "btop" exists in scratchpad
window=$(xdotool search --name "btop")

if [ -n "$window" ]; then
    # If the window is found, show it from scratchpad
    i3-msg '[title="btop"] scratchpad show'
else
    # If the window is not found, open a new terminal with btop, set the font size, and move it to scratchpad
    xterm -T "btop" -fa "$font" -fs "$font_size" -e btop &
    sleep 0.5  # Wait a little for the window to open
    i3-msg '[title="btop"] move to scratchpad'
    i3-msg '[title="btop"] scratchpad show'
fi

