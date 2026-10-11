#!/bin/bash

LAST_STATE=""

while true; do

    WINDOW=$(xdotool getactivewindow 2>/dev/null)

    if [ -n "$WINDOW" ]; then

        STATE=$(xprop -id "$WINDOW" _NET_WM_STATE 2>/dev/null)

        if echo "$STATE" | grep -q "_NET_WM_STATE_FULLSCREEN"; then
            CURRENT="fullscreen"
        else
            CURRENT="normal"
        fi

        if [ "$CURRENT" != "$LAST_STATE" ]; then

            if [ "$CURRENT" = "fullscreen" ]; then
                polybar-msg cmd hide
            else
                polybar-msg cmd show
            fi

            LAST_STATE="$CURRENT"
        fi
    fi

    sleep 0.5
done
