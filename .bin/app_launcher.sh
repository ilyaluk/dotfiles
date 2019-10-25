#!/bin/bash

apps='
firefox
telegram-desktop
keepassxc
kitty
'

echo $apps | tr ' ' '\n' | fzf --color=bw --reverse | xargs swaymsg exec --
