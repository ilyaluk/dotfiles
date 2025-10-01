#!/bin/bash

PLAYER_STATE="$(echo "$INFO" | jq -r '.["Player State"]')"
CURRENT_ARTIST="$(echo "$INFO" | jq -r '.Artist')"
CURRENT_SONG="$(echo "$INFO" | jq -r '.Name')"

CURRENT_ARTIST="${CURRENT_ARTIST:0:15}"

if [ "$PLAYER_STATE" = "Playing" ]; then
  sketchybar --set $NAME \
    icon.drawing=off \
    label="$CURRENT_ARTIST: $CURRENT_SONG" \
    label.drawing=on \
    background.image.drawing=off
else
  sketchybar --set $NAME \
    icon="" \
    icon.drawing=on \
    label.drawing=off \
    background.image.drawing=off
fi
