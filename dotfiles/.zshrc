# Homebrew setup
if [ -n "$(command -v brew 2> /dev/null)" ]; then
    brew_prefix=$(brew --prefix)

    # Completion from Homebrew
    if [ -f "${brew_prefix}"/share/zsh-completions ]; then
        fpath=("${brew_prefix}"/share/zsh-completions $fpath)
    fi
fi

# Emacs
if [ -n "$(command -v emacsclient 2> /dev/null)" ]; then
    export ALTERNATE_EDITOR=
    export EDITOR="emacsclient -a vi"
fi

# local zshrc
if [ -e "${HOME}"/.zshrc.local ]; then
    source "${HOME}"/.zshrc.local
fi
