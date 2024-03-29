# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Homebrew setup
if [ -n "$(command -v brew 2> /dev/null)" ]; then
    brew_prefix="$(brew --prefix)"

    # Completion from Homebrew
    if [ -f "${brew_prefix}"/etc/bash_completion ]; then
        source "${brew_prefix}"/etc/bash_completion
    fi
fi

# History
export HISTCONTROL="erasedups:ignoreboth"

shopt -s histappend
shopt -s cmdhist

# local bashrc
if [ -e "${HOME}"/.bashrc.local ]; then
    source "${HOME}"/.bashrc.local
fi
