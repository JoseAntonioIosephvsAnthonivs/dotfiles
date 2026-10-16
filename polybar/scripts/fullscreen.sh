
#!/bin/bash

LAST_STATE=""

while true; do
    CURRENT="normal"

    while read -r WINDOW; do
        STATE=$(xprop -id "$WINDOW" _NET_WM_STATE 2>/dev/null)

        if [[ "$STATE" == *"_NET_WM_STATE_FULLSCREEN"* ]]; then
            CURRENT="fullscreen"
            break
        fi
    done < <(wmctrl -l | awk '{print $1}')

    if [[ "$CURRENT" != "$LAST_STATE" ]]; then
        if [[ "$CURRENT" == "fullscreen" ]]; then
            polybar-msg cmd hide
        else
            polybar-msg cmd show
        fi

        LAST_STATE="$CURRENT"
    fi

    sleep 0.5
done

