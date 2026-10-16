#!/bin/bash

STATE="$HOME/.cache/polybar-desktop-state"
mkdir -p "$HOME/.cache"

case "$1" in
    show)
        # Guarda a janela ativa antes de mostrar a área de trabalho
        xdotool getactivewindow > "$STATE" 2>/dev/null
        wmctrl -k on
        ;;

    restore)
        # Retira o modo "mostrar área de trabalho"
        wmctrl -k off

        # Restaura a janela anteriormente ativa
        if [[ -s "$STATE" ]]; then
            window_id=$(cat "$STATE")
            wmctrl -ia "$window_id"
        fi
        ;;

    *)
        echo "Uso: $0 {show|restore}"
        exit 1
        ;;
esac
