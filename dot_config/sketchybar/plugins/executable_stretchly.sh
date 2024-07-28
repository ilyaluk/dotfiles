#!/bin/sh

if ps -axf | grep 'Stretchl[y].app'; then
    sketchybar --set "$NAME" drawing=off
else
    sketchybar --set "$NAME" drawing=on icon="S" icon.color=0xffff0000
fi
