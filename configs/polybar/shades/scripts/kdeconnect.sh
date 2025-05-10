#!/usr/bin/env bash

# Nome do dispositivo emparelhado
DEVICE_NAME="moto g8 power lite"

# Verifica se o dispositivo está conectado
if kdeconnect-cli --list-devices | grep -q "$DEVICE_NAME"; then
    echo "📱 $DEVICE_NAME"
else
    echo "📴 Dispositivo desconectado"
fi

