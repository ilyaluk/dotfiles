#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ "$SENDER" = "volume_change" ]; then
  OUTPUT="$(SwitchAudioSource -c)"
  ICON="󰋋"
  if [[ "$OUTPUT" = *"Speakers" ]]; then
    ICON="󰕾"
  fi
  VOLUME="$INFO"
  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
fi
