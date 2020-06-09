#!/bin/bash

apps='
chromium
google-chrome
telegram-desktop
spotify
emacs
keepassxc
goland-eap
kitty
zathura
subl3
wireshark
qbittorrent
wire-desktop
libreoffice
virt-manager
vncviewer
pycharm
jetbrains-toolbox
firefox
virtualbox
steam
tor-browser
calibre
ghidra
gimp
openttd
gthumb
skypeforlinux
audacity
jd-gui
minecraft-launcher 
golly
'

echo $apps | tr ' ' '\n' | fzf --color=bw --reverse | xargs $1msg exec --
