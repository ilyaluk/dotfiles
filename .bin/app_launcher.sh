#!/bin/bash

apps='
firefox
telegram-desktop
spotify
goland
keepassxc
kitty
zathura
'

echo $apps | tr ' ' '\n' | fzf --color=bw --reverse | xargs swaymsg exec --
