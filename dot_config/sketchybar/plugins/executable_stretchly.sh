#!/bin/sh



if ps -axf | grep -q 'Stretchl[y].app' > /dev/null; then
    sketchybar --set "$NAME" drawing=off
else
    sketchybar --set "$NAME" drawing=on icon="S" icon.color=0xffff0000
fi
