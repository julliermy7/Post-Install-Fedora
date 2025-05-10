#!/bin/bash

# Nome do dispositivo emparelhado
DEVICE_NAME="moto g8 power lite"

# Funções do KDE Connect
battery_status() {
    kdeconnect-cli --battery "$DEVICE_NAME"
}

send_file() {
    # Modifique para o caminho do arquivo que deseja enviar
    FILE_PATH="/caminho/para/o/arquivo"
    kdeconnect-cli --send "$DEVICE_NAME" "$FILE_PATH"
}

device_info() {
    kdeconnect-cli --info "$DEVICE_NAME"
}

# Mostrar opções
options=$(echo -e "1. Ver bateria\n2. Enviar arquivo\n3. Informações do dispositivo")

# Exibe um menu e captura a opção selecionada
choice=$(echo -e "$options" | rofi -no-config -no-lazy-grab -dmenu -i -p -theme ~/.config/polybar/shades/scripts/rofi/launcher.rasi "Escolha uma ação")

case "$choice" in
    "1. Ver bateria")
        battery_status
        ;;
    "2. Enviar arquivo")
        send_file
        ;;
    "3. Informações do dispositivo")
        device_info
        ;;
    *)
        echo "Opção inválida"
        ;;
esac
