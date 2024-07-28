#!/usr/bin/env bash


MONITORS=$(aerospace list-monitors | cut -d' ' -f1)

args=()

if [ "$(echo "$MONITORS" | wc -l)" -eq 1 ]; then
    echo "Single monitor"
    WORKSPACES=$(seq 1 9)
    for WS in $WORKSPACES; do
        args+=(--set space.$WS display=)
    done
else
    echo "Multiple monitors"
    for MONITOR in $MONITORS; do
        WORKSPACES=$(aerospace list-workspaces --monitor $MONITOR)
        for WS in $WORKSPACES; do
            # that's extremely hacky, but works for now
            args+=(--set space.$WS display=$((3 - $MONITOR)))
        done
    done
fi

echo "sketchybar ${args[@]}"
sketchybar "${args[@]}"
