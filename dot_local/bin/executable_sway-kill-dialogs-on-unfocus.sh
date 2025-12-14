#!/bin/bash

KILL_ON_UNFOCUS_ARRAY=(
    "launcher"
    "blueman-manager"
    "org.twosheds.iwgtk"
    "org.pulseaudio.pavucontrol"
    "org.keepassxc.KeePassXC"
    "it.mijorus.smile"
)
KILL_ON_UNFOCUS=$(IFS='|'; echo "${KILL_ON_UNFOCUS_ARRAY[*]}")

declare -A tracked_windows
declare -A pending_kills

swaymsg -t subscribe -m '["window"]' |
jq --unbuffered -r 'select(.change == "focus") | .container | .id, .app_id' |
while read -r con_id; read -r app_id; do
    # Check if this app_id should be tracked
    if [[ "$app_id" =~ ^($KILL_ON_UNFOCUS)$ ]]; then
        # Cancel any pending kill for this app if it regained focus
        if [ -n "${pending_kills[$app_id]}" ]; then
            kill "${pending_kills[$app_id]}" 2>/dev/null
            unset pending_kills["$app_id"]
        fi
        # Store the window ID when tracked app gains focus
        tracked_windows["$app_id"]="$con_id"
    fi

    # Check if focus changed away from any tracked window
    for tracked_app in "${!tracked_windows[@]}"; do
        if [ "$app_id" != "$tracked_app" ] && [ -n "${tracked_windows[$tracked_app]}" ]; then
            # Focus changed away from tracked app, schedule kill after 500ms
            stored_con_id="${tracked_windows[$tracked_app]}"
            (
                sleep 0.5
                swaymsg "[con_id=${stored_con_id}] kill" &>/dev/null
            ) &
            pending_kills["$tracked_app"]=$!
            unset tracked_windows["$tracked_app"]
        fi
    done
done
