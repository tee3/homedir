# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# History
HISTSIZE=20000
HISTCONTROL="erasedups:ignoreboth"

shopt -s histappend
shopt -s cmdhist

# Emacs
if [ -n "$(command -v emacsclient 2> /dev/null)" ]; then
    export ALTERNATE_EDITOR=
    export EDITOR="emacsclient -a vi"
fi

# local bashrc
if [ -e "${HOME}"/.bashrc.local ]; then
    source "${HOME}"/.bashrc.local
fi
