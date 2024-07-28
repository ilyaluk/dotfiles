#!/usr/bin/env bash

WORKSPACES=$(seq 1 9)

function highlight_active_workspace() {
    ACTIVE_COLOR=0x80ddffdd
    INACTIVE_COLOR=0x30ffffff

    args=()
    for WS in $WORKSPACES; do
        if [ "$WS" = "$1" ]; then
            args+=(--set space.$WS background.color=$ACTIVE_COLOR)
        else
            args+=(--set space.$WS background.color=$INACTIVE_COLOR)
        fi
    done
    sketchybar "${args[@]}"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
    highlight_active_workspace "$FOCUSED_WORKSPACE"

else
    # initial load, highlight active workspace from lookup
    highlight_active_workspace $(aerospace list-workspaces --focused)
fi
