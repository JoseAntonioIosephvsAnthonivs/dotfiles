
#!/bin/bash

# Clique em uma janela: focar ou minimizar
if [[ "$1" == "toggle" && -n "$2" ]]; then
    id="$2"
    active=$(xdotool getactivewindow 2>/dev/null)

    if [[ "$active" == "$id" ]]; then
        xdotool windowminimize "$id"
    else
        wmctrl -ia "$id"
    fi
    exit 0
fi

# Listar janelas abertas, ignorando painel, desktop e Polybar
while read -r id desktop class host title; do
    [[ -z "$id" ]] && continue
    [[ "$desktop" == "-1" ]] && continue

    case "${class,,}" in
        brave-browser.*|brave-browser)
            icon="󰖟"
            ;;
        thunar.*|thunar)
            icon=""
            ;;
        org.xfce.mousepad.*|mousepad.*)
            icon=""
            ;;
        xfce4-terminal.*)
            icon=""
            ;;
        *)
            icon=""
            ;;
    esac

    # Destacar a janela ativa
    active=$(xdotool getactivewindow 2>/dev/null)
    if [[ "$active" == "$id" ]]; then
        color="#5938ff"
    else
        color="#b4befe"
    fi

    printf '%%{A1:%s toggle %s:}%%{F%s}%s%%{F-}%%{A} ' \
        "$HOME/.config/polybar/scripts/taskbar.sh" \
        "$id" "$color" "$icon"

done < <(wmctrl -lx)

echo
