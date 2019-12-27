# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Homebrew setup
if [ -d /usr/local/Hombrew ]; then
    eval $(/usr/local/Homebrew/bin/brew shellenv)
elif [ -d "${HOME}"/.homebrew ]; then
    eval $("${HOME}"/.homebrew/bin/brew shellenv)
elif [ -d /home/linuxbrew/.linuxbrew ]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
elif [ -d "${HOME}"/.linuxbrew ]; then
    eval $("${HOME}"/.linuxbrew/bin/brew shellenv)
fi

if [ -n "$(command -v brew 2> /dev/null)" ]; then
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
if [ -n "$(command -v python 2> /dev/null)" ]; then
    export PATH="$(python -c 'import site ; print(site.USER_BASE)')/bin":${PATH}
fi

# Python 3
if [ -n "$(command -v python3 2> /dev/null)" ]; then
    export PATH="$(python3 -c 'import site ; print(site.USER_BASE)')/bin":${PATH}
fi

# Ruby
if [ -n "$(command -v ruby 2> /dev/null)" ] && [ -n "$(command -v gem 2> /dev/null)" ]; then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin":${PATH}
fi

# Node.js
if [ -n "$(command -v node 2> /dev/null)" ]; then
    npm_prefix=$(npm prefix -g)
    export PATH="${npm_prefix}"/bin:${PATH}
    export MANPATH="${npm_prefix}"/share/man:${MANPATH}
    export NODE_PATH="${npm_prefix}"/lib/node_modules:${NODE_PATH}
fi

# Go
if [ -n "$(command -v go 2> /dev/null)" ]; then
    export PATH="${HOME}"/.go/bin:${PATH}
fi

# Rust
if [ -n "$(command -v cargo 2> /dev/null)" ]; then
    export PATH="${HOME}"/.cargo/bin:${PATH}
fi

# Lua
if [ -n "$(command -v luarocks 2> /dev/null)" ]; then
    export PATH="${HOME}"/.luarocks/bin:${PATH}
fi

# Emacs
if [ -n "$(command -v emacsclient 2> /dev/null)" ]; then
    export ALTERNATE_EDITOR=
    export EDITOR="emacsclient -a vi"
fi

# MATLAB
matlab_prefix=/Applications/MATLAB_R2017b.app
if [ -n "$(command -v ${matlab_prefix}/bin/matlab 2> /dev/null)" ]; then
    export PATH="${matlab_prefix}"/bin:${PATH}
fi

# NVIDIA
nvidia_prefix=/Developer/NVIDIA/CUDA-9.2
if [ -n "$(command -v ${nvidia_prefix}/bin/nvcc 2> /dev/null)" ]; then
    export PATH="${nvidia_prefix}"/bin:${PATH}
    export MANPATH="${nvidia_prefix}"/doc/man:${MANPATH}
fi

# never use ccache, no matter what
export CCACHE_DISABLE=""

# local bashrc
if [ -e "${HOME}"/.bashrc.local ]; then
    source "${HOME}"/.bashrc.local
fi
