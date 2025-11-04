#!/bin/sh

echo '[main]\ninitial-color-theme = 2' > ~/.config/foot/theme.ini
pkill -USR2 foot
