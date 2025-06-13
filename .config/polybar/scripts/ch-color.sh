#!/bin/bash

NEW_COLOR="$1"

# Verifica se uma cor foi fornecida
if [ -z "$NEW_COLOR" ]; then
    echo "Uso: $0 <hex_color_code>"
    echo "Exemplo: $0 #FF00FF"
    exit 1
fi

# Validação básica de cor hex (opcional, mas recomendado)
if ! [[ "$NEW_COLOR" =~ ^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$ ]]; then
    echo "Cor inválida. Use um código HEX válido (ex: #FF00FF ou #F0F)."
    exit 1
fi

# Define a variável de ambiente para a sessão atual do shell
# Isso é importante para que o script que inicia a Polybar a veja
export ACCENT_COLOR="$NEW_COLOR"

# Mata todas as instâncias da Polybar
killall -q polybar

# Espera até que os processos Polybar tenham sido encerrados
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Inicia a Polybar (assumindo que você tem um script de inicialização como launch.sh)
# Se você inicia a Polybar de outra forma, adapte aqui.
# Exemplo: ~/.config/polybar/launch.sh &
# Ou simplesmente: polybar main &
polybar main & # Adapte para como você inicia sua barra
echo "Cor de destaque da Polybar alterada para $NEW_COLOR"
