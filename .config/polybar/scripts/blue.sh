#!/bin/bash
#!/bin/bash

# Cores passadas como argumentos da Polybar
COLOR_CONNECTED_ICON="#a9ddea"
COLOR_DISCONNECTED_ICON="#5b5e5c" # Cor hardcoded para desconectado
COLOR_TEXT_DEVICE_NAME="#a9ddea" # Usando $1 para a cor do texto do nome do dispositivo
COLOR_OFF="#a9ddea" # Cor para Bluetooth desligado, vindo como $2

# Define os ícones (coloque os mesmos que você usa)
ICON_ON="󰂯"
ICON_OFF="󰂲"

# Caminhos absolutos para os comandos (ajuste se os seus forem diferentes)
BLUETOOTHCTL="/usr/bin/bluetoothctl"
GREP="/usr/bin/grep"
AWK="/usr/bin/awk"
HEAD="/usr/bin/head"
PGREP="/usr/bin/pgrep"

# Obter o status do adaptador Bluetooth
BLUETOOTH_POWER_STATUS=$($BLUETOOTHCTL show | $GREP "Powered" | $AWK '{print $2}')

# Verificar se há algum dispositivo conectado
CONNECTED_DEVICES=$($BLUETOOTHCTL devices Connected | $AWK '{print $2}')

OUTPUT="" # Variável para armazenar a saída final

if [ "$BLUETOOTH_POWER_STATUS" == "yes" ]; then
    if [ -n "$CONNECTED_DEVICES" ]; then
        # Bluetooth ligado e conectado a um dispositivo
        FIRST_DEVICE_MAC=$(echo "$CONNECTED_DEVICES" | $HEAD -n 1)
        CONNECTED_DEVICE_NAME=$($BLUETOOTHCTL info "$FIRST_DEVICE_MAC" | $GREP "Name" | $AWK '{print $2}')

        # Formato de saída para Polybar: Ícone com cor de conectado, nome do dispositivo com cor específica
        OUTPUT="%{F$COLOR_CONNECTED_ICON}$ICON_ON%{F-}%{F$COLOR_TEXT_DEVICE_NAME} $CONNECTED_DEVICE_NAME%{F-}"
    else
        # Bluetooth ligado, mas sem dispositivo conectado
        # Formato de saída para Polybar: Ícone com a cor de "ligado e desconectado"
        OUTPUT="%{F$COLOR_DISCONNECTED_ICON}$ICON_ON%{F-}"
    fi
else
    # Bluetooth desligado
    # Formato de saída para Polybar: Ícone de desligado com cor de desligado
    OUTPUT="%{F$COLOR_OFF}$ICON_OFF%{F-}"
fi

# --- LINHA DE DEPURAÇÃO ---
# Esta linha vai imprimir a string exata que está sendo enviada para a Polybar.
# Você pode remover ou comentar esta linha depois que o problema for resolvido.
echo "DEBUG: Output string: $OUTPUT" > /tmp/polybar_bluetooth_debug.log
# --- FIM DA LINHA DE DEPURAÇÃO ---

echo "$OUTPUT"
