#!/bin/bash

KILL_ON_UNFOCUS_ARRAY=(
    "launcher"
    "blueman-manager"
    "org.twosheds.iwgtk"
    "org.pulseaudio.pavucontrol"
    "it.mijorus.smile"
)
KILL_ON_UNFOCUS=$(IFS='|'; echo "${KILL_ON_UNFOCUS_ARRAY[*]}")

declare -A tracked_windows

swaymsg -t subscribe -m '["window"]' |
jq --unbuffered -r 'select(.change == "focus") | .container | .id, .app_id' |
while read -r con_id; read -r app_id; do
    # Check if this app_id should be tracked
    if [[ "$app_id" =~ ^($KILL_ON_UNFOCUS)$ ]]; then
        # Store the window ID when tracked app gains focus
        tracked_windows["$app_id"]="$con_id"
    fi

    # Check if focus changed away from any tracked window
    for tracked_app in "${!tracked_windows[@]}"; do
        if [ "$app_id" != "$tracked_app" ] && [ -n "${tracked_windows[$tracked_app]}" ]; then
            # Focus changed away from tracked app, kill it
            swaymsg "[con_id=${tracked_windows[$tracked_app]}] kill" 2>/dev/null
            unset tracked_windows["$tracked_app"]
        fi
    done
done
