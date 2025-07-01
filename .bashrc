# ~/.bashrc

[[ $- != *i* ]] && return
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias ins='sudo pacman -S'
alias rem='sudo pacman -R'
alias upd='sudo pacman -Syu'
alias sys='sudo systemctl'
alias wifi='sudo dhcpcd enp1s0f0u7'

# functions
wp() {
    local file=""
    for ext in png jpeg jpg; do
        if [[ -f "$HOME/.wp/$1.$ext" ]]; then
            file="$HOME/.wp/$1.$ext"
            break
        fi
    done

    if [[ -n $file ]]; then
        nitrogen --set-auto "$file"
    else
        echo "[ERROR]: $1.(png|jpeg|jpg) not found in ~/.wp"
    fi
}

pcolor() {
    local HEX_COLOR="$1"

    pcolor_usage() {
        echo "Uso: pcolor <código_hex_da_cor>"
        echo "Exemplo: pcolor #FF00FF"
        echo "Use aliases para cores predefinidas, ex: alias pwhite='pcolor #FFFFFF'"
    }

    if [ -z "$HEX_COLOR" ]; then
        pcolor_usage
        return 1
    fi

    if ! [[ "$HEX_COLOR" =~ ^#([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$ ]]; then
        echo "[ERROR]: Invalid hex code. Use #RRGGBB or #RGB."
        pcolor_usage
        return 1
    fi

    export acc_color="$HEX_COLOR"

    killall -q polybar
    while pgrep -u "$(id -u)" -x polybar >/dev/null; do sleep 1; done
    nohup polybar main &
}

alias d='pcolor "#e6ecd1"'
alias d-b='pcolor "#9c47e8"'
alias d2='pcolor "#ded1ec"'
alias blue='pcolor "#a9ddea"'
alias rs='pcolor "#f99aed"'
alias red='pcolor "#f66b6b"'
alias nasa='pcolor "#e33071"'
alias nasa2='pcolor "#e35b8d"'
