autoload -U compinit
compinit -i

# Homebrew setup
if [ -n "$(command -v brew 2> /dev/null)" ]; then
    brew_prefix="$(brew --prefix)"

    # Completion from Homebrew
    if [ -f "${brew_prefix}"/share/zsh-completions ]; then
        fpath=("${brew_prefix}"/share/zsh-completions $fpath)
    fi
fi

if command -v gh > /dev/null ; then
    gh completion -s zsh > /usr/local/share/zsh/site-functions/_gh
fi

# local zshrc
if [ -e "${HOME}"/.zshrc.local ]; then
    source "${HOME}"/.zshrc.local
fi
