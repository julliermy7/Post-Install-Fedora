#!/bin/bash

chosen=$(echo -e "⏻ Desligar\n Reiniciar\n Suspender\n Bloquear Tela\n󰗽 Cancelar" | fuzzel --dmenu)

case "$chosen" in
    "⏻ Desligar") systemctl poweroff ;;
    " Reiniciar") systemctl reboot ;;
    " Suspender") systemctl suspend ;;
    " Bloquear tela") loginctl lock-session ;;
    *) exit 0 ;;
esac
