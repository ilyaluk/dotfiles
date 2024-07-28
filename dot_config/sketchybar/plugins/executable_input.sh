#!/bin/sh

input=$(
    defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources |
        grep 'KeyboardLayout Name')

icon="❓"
bg="on"
case "$input" in
    *"U.S."*)
        icon="EN"
        bg="off"
        ;;
    *"ABC"*)
        icon="EN"
        bg="off"
        ;;
    *"Russian"*)
        icon="RU"
        ;;
esac

sketchybar --set "$NAME" icon="$icon" background.drawing="$bg"
