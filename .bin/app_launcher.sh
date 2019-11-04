#!/bin/bash

apps='
firefox
telegram-desktop
goland
keepassxc
kitty
'

echo $apps | tr ' ' '\n' | fzf --color=bw --reverse | xargs swaymsg exec --
