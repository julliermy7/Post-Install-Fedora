#!/usr/bin/env bash

NOTIFY_ICON=/usr/share/icons/Papirus/32x32/apps/system-software-update.svg

get_total_updates() {
    UPDATES=$(dnf check-update --refresh 2>/dev/null | grep -E '^[a-zA-Z0-9]' | wc -l)
}

while true; do
    get_total_updates

    # Notifica o usuário se houver atualizações
    if hash notify-send &>/dev/null; then
        if (( UPDATES > 50 )); then
            notify-send -u critical -i "$NOTIFY_ICON" \
                "Você precisa atualizar imediatamente!" "$UPDATES pacotes novos"
        elif (( UPDATES > 25 )); then
            notify-send -u normal -i "$NOTIFY_ICON" \
                "Atualizações recomendadas" "$UPDATES pacotes novos"
        elif (( UPDATES > 2 )); then
            notify-send -u low -i "$NOTIFY_ICON" \
                "$UPDATES pacotes novos disponíveis"
        fi
    fi

    # Quando houver atualizações, verifica a cada 10 segundos
    while (( UPDATES > 0 )); do
        if (( UPDATES == 1 )); then
            echo " $UPDATES"
        elif (( UPDATES > 1 )); then
            echo " $UPDATES"
        else
            echo " Nenhuma atualização."
        fi
        sleep 10
        get_total_updates
    done

    # Quando não houver atualizações, verifica a cada 30 minutos
    while (( UPDATES == 0 )); do
        echo " Nenhuma atualização."
        sleep 1800
        get_total_updates
    done
done
