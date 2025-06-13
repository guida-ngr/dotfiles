#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias ins='sudo pacman -S'
alias rem='sudo pacman -R'
alias upd='sudo pacman -Syu'
alias sys='sudo systemctl'
alias uncharge='adb shell dumpsys battery unplug'
alias charge='adb shell dumpsys battery reset'
alias d='pcolor "#e6ecd1"'
alias d2='pcolor "#ded1ec"'
wp() {
    local file=""
    for ext in png jpeg jpg; do
        if [[ -f "$HOME/Downloads/$1.$ext" ]]; then
            file="$HOME/Downloads/$1.$ext"
            break
        fi
    done

    if [[ -n $file ]]; then
        nitrogen --set-auto "$file"
    else
        echo "Arquivo não encontrado: $1.(png|jpeg|jpg) em ~/Downloads"
    fi
}

pcolor() {
    local HEX_COLOR="$1"

    # Função para exibir o uso
    show_pcolor_usage() {
        echo "Uso: pcolor <código_hex_da_cor>"
        echo "Exemplo: pcolor #FF00FF"
        echo "Use aliases para cores predefinidas, ex: alias pwhite='pcolor #FFFFFF'"
    }

    # Verifica se um argumento foi fornecido
    if [ -z "$HEX_COLOR" ]; then
        show_pcolor_usage
        return 1
    fi

    # Valida se é um código hex válido
    if ! [[ "$HEX_COLOR" =~ ^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$ ]]; then
        echo "Erro: Código hexadecimal inválido. Use o formato #RRGGBB ou #RGB."
        show_pcolor_usage
        return 1
    fi

    # Define a variável de ambiente GLOBALMENTE para esta sessão do shell
    export ACCENT_COLOR="$HEX_COLOR"

    # Mata todas as instâncias da Polybar
    killall -q polybar

    # Espera até que os processos Polybar tenham sido encerrados
    while pgrep -u "$(id -u)" -x polybar >/dev/null; do sleep 1; done

    # Inicia a Polybar (adapte para como você inicia sua barra, ex: polybar main &)
    nohup polybar main & 
    echo "Cor de destaque da Polybar alterada para $HEX_COLOR"
}
