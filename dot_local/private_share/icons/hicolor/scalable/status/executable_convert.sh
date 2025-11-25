#!/bin/bash

for img in blueman blueman-active blueman-disabled blueman-tray; do
    gtk4-encode-symbolic-svg ~/.local/share/icons/hicolor/scalable/status/${img}.svg 1024x1024 -o ~/
    for sz in 128 16 192 22 24 256 32 48 64 72 96; do
        convert ~/${img}.symbolic.png -resize $((${sz} * 8 / 10))x$((${sz} * 8 / 10)) -background none -gravity center -extent ${sz}x${sz} -channel RGB -negate ~/.local/share/icons/hicolor/${sz}x${sz}/status/${img}.png
    done
    rm ~/${img}.symbolic.png
done

gtk-update-icon-cache -f -t ~/.local/share/icons/hicolor
