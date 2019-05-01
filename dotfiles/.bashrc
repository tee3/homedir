# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Homebrew setup
if [ -d /usr/local/Hombrew ]; then
    eval $(/usr/local/Homebrew/bin/brew shellenv)
elif [ -d ~/.homebrew ]; then
    eval $(~/.homebrew/bin/brew shellenv)
elif [ -d /home/linuxbrew/.linuxbrew ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
elif [ -d ~/.linuxbrew ]; then
    eval $(~/.linuxbrew/bin/brew shellenv)
fi

if [ -n "$(which brew 2> /dev/null)" ]; then
    brew_prefix=$(brew --prefix)

    # Completion from Homebrew
    if [ -f "${brew_prefix}"/etc/bash_completion ]; then
        source "${brew_prefix}"/etc/bash_completion
    fi

    # DocBook from Homebrew
    if [ -e "$(brew ls --versions docbook > /dev/null)" ]; then
        export XML_CATALOG_FILES=${brew_prefix}/etc/xml/catalog
    fi
fi

# Add local optional to path
if [ -d "${HOME}"/opt/local/bin ]; then
    export PATH="${HOME}"/opt/local/bin:"${PATH}"
    export LD_LIBRARY_PATH="${HOME}"/opt/local/lib
    export DYLD_LIBRARY_PATH="${HOME}"/opt/local/lib
fi

# History
HISTSIZE=20000
HISTCONTROL="erasedups:ignoreboth"

shopt -s histappend
shopt -s cmdhist

# Python (default)
if [ -n "$(which python 2> /dev/null)" ]; then
    export PATH="$(python -c 'import site ; print(site.USER_BASE)')/bin":${PATH}
fi

# Python 3
if [ -n "$(which python3 2> /dev/null)" ]; then
    export PATH="$(python3 -c 'import site ; print(site.USER_BASE)')/bin":${PATH}
fi

# Ruby
if [ -n "$(which ruby 2> /dev/null)" ] && [ -n "$(which gem 2> /dev/null)" ]; then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin":${PATH}
fi

# Node.js
if [ -n "$(which node 2> /dev/null)" ]; then
    npm_prefix=$(npm prefix -g)
    export PATH="${npm_prefix}"/bin:${PATH}
    export MANPATH="${npm_prefix}"/share/man:${MANPATH}
    export NODE_PATH="${npm_prefix}"/lib/node_modules:${NODE_PATH}
fi

# Go
if [ -n "$(which go 2> /dev/null)" ]; then
    export PATH="${HOME}"/.go/bin:${PATH}
fi

# Rust
if [ -n "$(which cargo 2> /dev/null)" ]; then
    export PATH="${HOME}"/.cargo/bin:${PATH}
fi

# Lua
if [ -n "$(which luarocks 2> /dev/null)" ]; then
    export PATH="${HOME}"/.luarocks/bin:${PATH}
fi

# Emacs
if [ -n "$(which emacsclient 2> /dev/null)" ]; then
    export ALTERNATE_EDITOR=
    export EDITOR="emacsclient -a vi"
fi

# MATLAB
matlab_prefix=/Applications/MATLAB_R2017b.app
if [ -n "$(which ${matlab_prefix}/bin/matlab 2> /dev/null)" ]; then
    export PATH="${matlab_prefix}"/bin:${PATH}
fi

# NVIDIA
nvidia_prefix=/Developer/NVIDIA/CUDA-9.2
if [ -n "$(which ${nvidia_prefix}/bin/nvcc 2> /dev/null)" ]; then
    export PATH="${nvidia_prefix}"/bin:${PATH}
    export MANPATH="${nvidia_prefix}"/doc/man:${MANPATH}
fi

# never use ccache, no matter what
export CCACHE_DISABLE=""

# local bashrc
if [ -e "${HOME}"/.bashrc.local ]; then
    source "${HOME}"/.bashrc.local
fi
