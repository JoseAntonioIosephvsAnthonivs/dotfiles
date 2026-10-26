
#!/bin/bash

LAST_STATE=""
LAST_PID=""

while true; do
    CURRENT="normal"

    # Verifica todas as janelas em busca de tela cheia
    while read -r WINDOW; do
        STATE=$(xprop -id "$WINDOW" _NET_WM_STATE 2>/dev/null)

        if [[ "$STATE" == *"_NET_WM_STATE_FULLSCREEN"* ]]; then
            CURRENT="fullscreen"
            break
        fi
    done < <(wmctrl -l | awk '{print $1}')

    # Descobre a instância atual da Polybar
    BAR_PID=$(pgrep -xo polybar)

    if [[ -n "$BAR_PID" ]]; then
        # Reenvia o comando se o estado mudou ou a barra reiniciou
        if [[ "$CURRENT" != "$LAST_STATE" ||
              "$BAR_PID" != "$LAST_PID" ]]; then

            if [[ "$CURRENT" == "fullscreen" ]]; then
                COMMAND="hide"
            else
                COMMAND="show"
            fi

            if polybar-msg -p "$BAR_PID" cmd "$COMMAND"; then
                LAST_STATE="$CURRENT"
                LAST_PID="$BAR_PID"
            fi
        fi
    fi

    sleep 0.5
done

