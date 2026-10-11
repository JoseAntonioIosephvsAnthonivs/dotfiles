#!/bin/bash

TEMP=$(sensors 2>/dev/null | awk '/Tctl:/ {gsub(/[+°C]/,"",$2); print $2; exit}')

if [ -n "$TEMP" ]; then
    echo " ${TEMP}°C"
else
    echo " N/A"
fi
