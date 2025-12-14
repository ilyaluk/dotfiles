#!/bin/sh

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
dbus-update-activation-environment GTK_THEME=Adwaita
