# History
export HISTSIZE=20000

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
    export PATH="${HOME}/bin${PATH:+:${PATH}}"
    export MANPATH="${HOME}/share/man${MANPATH:+:${MANPATH}}"
    export INFOPATH="${HOME}/share/info:${INFOPATH:-}"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ] ; then
    export PATH="${HOME}/.local/bin${PATH:+:${PATH}}"
    export MANPATH="${HOME}/.local/share/man${MANPATH:+:${MANPATH}}"
    export INFOPATH="${HOME}/.local/share/info:${INFOPATH:-}"
fi

# Homebrew setup
if [ -d /usr/local/Homebrew ]; then
    eval "$(/usr/local/Homebrew/bin/brew shellenv)"
elif [ -d "${HOME}"/.homebrew ]; then
    eval "$("${HOME}"/.homebrew/bin/brew shellenv)"
elif [ -d /home/linuxbrew/.linuxbrew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -d "${HOME}"/.linuxbrew ]; then
    eval "$("${HOME}"/.linuxbrew/bin/brew shellenv)"
fi

if [ -n "$(command -v brew 2> /dev/null)" ]; then
    brew_prefix="$(brew --prefix)"

    # DocBook from Homebrew
    if [ -e "$(brew ls --versions docbook > /dev/null)" ]; then
        export XML_CATALOG_FILES="${brew_prefix}"/etc/xml/catalog
    fi
fi

# Add local optional to path
if [ -d "${HOME}"/opt/local/bin ]; then
    export PATH="${HOME}/opt/local/bin${PATH:+:${PATH}}"
    export LD_LIBRARY_PATH="${HOME}/opt/local/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
    export DYLD_LIBRARY_PATH="${HOME}/opt/local/lib${DYLD_LIBRARY_PATH:+:${DYLD_LIBRARY_PATH}}"
    export MANPATH="${HOME}/opt/local/share/man${MANPATH:+:${MANPATH}}"
    export INFOPATH="${HOME}/opt/local/share/info:${INFOPATH:-}"
fi

# Editor
if [ -n "$(command -v emacsclient 2> /dev/null)" ]; then
    export ALTERNATE_EDITOR=
    export EDITOR="emacsclient -a vi"
fi

# Python 3
if [ -n "$(command -v python3 2> /dev/null)" ]; then
    python_prefix="$(python3 -c 'import site ; print(site.USER_BASE)')"
    export PATH="${python_prefix}/bin${PATH:+:${PATH}}"
fi

# Ruby
if [ -n "$(command -v ruby 2> /dev/null)" ] && [ -n "$(command -v gem 2> /dev/null)" ]; then
    ruby_prefix="$(ruby -r rubygems -e 'puts Gem.user_dir')"
    export PATH="${ruby_prefix}/bin${PATH:+:${PATH}}"
fi

# Node.js
if [ -n "$(command -v node 2> /dev/null)" ]; then
    npm_prefix="$(npm prefix -g)"
    export PATH="${npm_prefix}/bin${PATH:+:${PATH}}"
    export MANPATH="${npm_prefix}/share/man${MANPATH:+:${MANPATH}}"
    export NODE_PATH="${npm_prefix}/lib/node_modules${NODE_PATH:+:${NODE_PATH}}"
fi

# Go
if [ -n "$(command -v go 2> /dev/null)" ]; then
    export PATH="${HOME}/.go/bin${PATH:+:${PATH}}"
fi

# Rust
if [ -n "$(command -v cargo 2> /dev/null)" ]; then
    export PATH="${HOME}/.cargo/bin${PATH:+:${PATH}}"
fi

# Lua
if [ -n "$(command -v luarocks 2> /dev/null)" ]; then
    export PATH="${HOME}/.luarocks/bin${PATH:+:${PATH}}"
fi

# TeX
tex_prefix=/usr/local/texlive/2022
if [ -d "${tex_prefix}" ]; then
    export MANPATH="${tex_prefix}/texmf-dist/doc/man${MANPATH:+:${MANPATH}}"
    export INFOPATH="${tex_prefix}/texmf-dist/doc/info:${INFOPATH:-}"
fi

# MATLAB
matlab_prefix=/Applications/MATLAB_R2017b.app
if [ -n "$(command -v ${matlab_prefix}/bin/matlab 2> /dev/null)" ]; then
    export PATH="${matlab_prefix}/bin${PATH:+:${PATH}}"
fi

# NVIDIA
nvidia_prefix=/Developer/NVIDIA/CUDA-9.2
if [ -n "$(command -v ${nvidia_prefix}/bin/nvcc 2> /dev/null)" ]; then
    export PATH="${nvidia_prefix}/bin${PATH:+:${PATH}}"
    export MANPATH="${nvidia_prefix}/doc/man${MANPATH:+:${MANPATH}}"
fi

# never use ccache, no matter what
export CCACHE_DISABLE=""

# local profile
if [ -e "${HOME}"/.profile.local ]; then
    . "${HOME}"/.profile.local
fi
