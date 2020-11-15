# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# History
export HISTCONTROL="erasedups:ignoreboth"

shopt -s histappend
shopt -s cmdhist

# local bashrc
if [ -e "${HOME}"/.bashrc.local ]; then
    source "${HOME}"/.bashrc.local
fi
