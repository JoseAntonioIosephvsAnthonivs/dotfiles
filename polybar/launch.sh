#!/bin/bash

killall polybar 2>/dev/null

sleep 1

polybar main &

sleep 1

~/.config/polybar/scripts/fullscreen.sh &
