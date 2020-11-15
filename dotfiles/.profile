# History
export HISTSIZE=20000

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
    export PATH="${HOME}"/bin"${PATH:+:${PATH}}"
    export INFOPATH="${HOME}"/share/info:"${INFOPATH:-}"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ] ; then
    export PATH="${HOME}"/.local/bin"${PATH:+:${PATH}}"
    export INFOPATH="${HOME}"/.local/share/info:"${INFOPATH:-}"
fi

if [ -e "${HOME}"/.nix-profile/etc/profile.d/nix.sh ]; then
    . "${HOME}"/.nix-profile/etc/profile.d/nix.sh
fi

# Add local optional to path
if [ -d "${HOME}"/opt/local ]; then
    export PATH="${HOME}"/opt/local/bin"${PATH:+:${PATH}}"
    export LD_LIBRARY_PATH="${HOME}"/opt/local/lib"${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
    export DYLD_LIBRARY_PATH="${HOME}"/opt/local/lib"${DYLD_LIBRARY_PATH:+:${DYLD_LIBRARY_PATH}}"
    export INFOPATH="${HOME}"/opt/local/share/info:"${INFOPATH:-}"
    export PKG_CONFIG_PATH="${HOME}"/opt/local/lib/pkgconfig"${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}"
fi

# Emacs for macOS
if [ -d "${HOME}"/Applications/Emacs.app ]; then
    alias emacs="${HOME}"/Applications/Emacs.app/Contents/MacOS/Emacs
    alias emacsclient="${HOME}"/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
    alias etags="${HOME}"/Applications/Emacs.app/Contents/MacOS/bin/etags
fi

# Editor
if [ -n "$(command -v emacsclient 2> /dev/null)" ]; then
    export VISUAL="emacsclient -a vi"
fi

# Python 3
if [ -n "$(command -v python3 2> /dev/null)" ]; then
    python_prefix="$(python3 -c 'import site ; print(site.USER_BASE)')"
    export PATH="${python_prefix}"/bin"${PATH:+:${PATH}}"
fi

# Ruby
if [ -n "$(command -v ruby 2> /dev/null)" ] && [ -n "$(command -v gem 2> /dev/null)" ]; then
    ruby_prefix="$(ruby -r rubygems -e 'puts Gem.user_dir')"
    export PATH="${ruby_prefix}"/bin"${PATH:+:${PATH}}"
fi

# Node.js
if [ -n "$(command -v node 2> /dev/null)" ]; then
    npm_prefix="$(npm prefix -g)"
    export PATH="${npm_prefix}"/bin"${PATH:+:${PATH}}"
    export NODE_PATH="${npm_prefix}"/lib/node_modules"${NODE_PATH:+:${NODE_PATH}}"
fi

# Go
if [ -n "$(command -v go 2> /dev/null)" ]; then
    export PATH="${HOME}"/go/bin"${PATH:+:${PATH}}"
fi

# Rust
if [ -n "$(command -v cargo 2> /dev/null)" ]; then
    export PATH="${HOME}"/.cargo/bin"${PATH:+:${PATH}}"
fi

# Lua
if [ -n "$(command -v luarocks 2> /dev/null)" ]; then
    eval "$(luarocks path --bin)"
fi

# TeX
tex_prefix=/usr/local/texlive/2022
if [ -d "${tex_prefix}" ]; then
    export INFOPATH="${tex_prefix}"/texmf-dist/doc/info:"${INFOPATH:-}"
fi

# MATLAB
matlab_prefix=/Applications/MATLAB_R2017b.app
if [ -n "$(command -v "${matlab_prefix}"/bin/matlab 2> /dev/null)" ]; then
    export PATH="${matlab_prefix}"/bin"${PATH:+:${PATH}}"
fi

# NVIDIA
nvidia_prefix=/Developer/NVIDIA/CUDA-9.2
if [ -n "$(command -v "${nvidia_prefix}"/bin/nvcc 2> /dev/null)" ]; then
    export PATH="${nvidia_prefix}"/bin"${PATH:+:${PATH}}"
fi

# never use ccache, no matter what
export CCACHE_DISABLE=""

# local profile
if [ -e "${HOME}"/.profile.local ]; then
    . "${HOME}"/.profile.local
fi
