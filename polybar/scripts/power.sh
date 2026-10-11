#!/bin/bash

OPTIONS=" Desligar
 Reiniciar
󰤄 Suspender
󰗼 Sair"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Energia")

case "$CHOICE" in
    " Desligar")
        systemctl poweroff
        ;;
    " Reiniciar")
        systemctl reboot
        ;;
    "󰤄 Suspender")
        systemctl suspend
        ;;
    "󰗼 Sair")
        xfce4-session-logout
        ;;
esac
