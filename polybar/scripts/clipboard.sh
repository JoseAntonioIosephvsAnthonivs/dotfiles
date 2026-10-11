#!/bin/bash

rofi -dmenu -p "Clipboard" < <(cliphist list) | cliphist decode | wl-copy
