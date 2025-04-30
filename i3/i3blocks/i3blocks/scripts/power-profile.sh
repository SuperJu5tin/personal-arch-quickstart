#!/bin/bash

# Get the current power profile
current_profile=$(powerprofilesctl get)

# Define spaceship-themed outputs based on power profile
case "$current_profile" in
    "power-saver")
        echo "󱎯 [DETATCHED]"
        ;;
    "performance")
        echo "󱎯 [HYPERDRIVE]"
        ;;
    "balanced")
	echo "󱎯 [STEADY]"
        ;;
    *)
        echo "󱎯 [AWAITING COMMAND]"
        ;;
esac

