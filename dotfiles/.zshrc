# Emacs
if [ -n "$(command -v emacsclient 2> /dev/null)" ]; then
    export ALTERNATE_EDITOR=
    export EDITOR="emacsclient -a vi"
fi

# local zshrc
if [ -e "${HOME}"/.zshrc.local ]; then
    source "${HOME}"/.zshrc.local
fi
