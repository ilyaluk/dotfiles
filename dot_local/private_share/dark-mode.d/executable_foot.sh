#!/bin/sh

echo '[main]\ninitial-color-theme = 1' > ~/.config/foot/theme.ini
pkill -USR1 foot
