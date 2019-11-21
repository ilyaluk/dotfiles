#!/bin/bash

apps='
firefox
google-chrome
telegram-desktop
spotify
goland
keepassxc
kitty
zathura
'

echo $apps | tr ' ' '\n' | fzf --color=bw --reverse | xargs swaymsg exec --
