#!/bin/bash

# Verifica se o pavucontrol está rodando
if pgrep -x "pavucontrol" > /dev/null
then
    # Se estiver rodando, mata todas as instâncias
    killall pavucontrol
else
    # Se não estiver rodando, inicia o pavucontrol
    # É uma boa prática iniciá-lo como um processo independente para que não morra com o terminal
    # E também definir sua posição e tamanho via i3/WM se desejar.
    nohup pavucontrol > /dev/null 2>&1 &
    # Ou, se você configurou o i3 para gerenciar sua posição/tamanho via `for_window`:
    # pavucontrol &
fi
