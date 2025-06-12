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
# nitrogen --set-seuto ~/.config/Downloads/$input
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
