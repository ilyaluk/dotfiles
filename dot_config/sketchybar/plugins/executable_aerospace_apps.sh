#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source $SCRIPT_DIR/../icon_map.sh

function set_apps_label() {
    # cut by |, get the second column, strip whitespace, remove duplicates while keeping order
    apps=$(aerospace list-windows --workspace $1 | cut -d'|' -f2 | awk '{$1=$1};1' | awk '!a[$0]++')
    if [ "$apps" != "" ]; then
        icon_strip=""
        while IFS= read -r app; do
            __icon_map "$app"
            icon_strip+="$icon_result"
        done <<< "$apps"
        sketchybar --set space.$WS label.drawing=on label="$icon_strip"
    else
        sketchybar --set space.$WS label.drawing=off
    fi
    # echo "$1: $icon_strip"
}

WORKSPACES=$(seq 1 9)

for WS in $WORKSPACES; do
    set_apps_label $WS &
done
wait
