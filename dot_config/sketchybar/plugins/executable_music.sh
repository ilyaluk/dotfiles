#!/bin/bash

PLAYER_STATE="$(echo "$INFO" | jq -r '.state')"
CURRENT_ARTIST="$(echo "$INFO" | jq -r '.artist')"
CURRENT_SONG="$(echo "$INFO" | jq -r '.title')"

CURRENT_ARTIST="${CURRENT_ARTIST:0:15}"

if [ "$PLAYER_STATE" = "playing" ]; then
  sketchybar --set $NAME \
    icon.drawing=off \
    label="$CURRENT_ARTIST: $CURRENT_SONG" \
    label.drawing=on \
    background.image.drawing=on
else
  sketchybar --set $NAME \
    icon="" \
    icon.drawing=on \
    label.drawing=off \
    background.image.drawing=off
fi
