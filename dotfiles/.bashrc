# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Homebrew setup
if [ -e /usr/local/bin/brew ]; then
    brew_prefix=$(/usr/local/bin/brew --prefix)

    export PATH=${brew_prefix}/bin:${brew_prefix}/sbin:${PATH}

    # Completion from Homebrew
    if [ -f "${brew_prefix}"/etc/bash_completion ]; then
        source "${brew_prefix}"/etc/bash_completion
    fi

    # Hunspell from Homebrew
    if [ -e "$(brew --prefix hunspell)" ]; then
        export DICTIONARY=en_US
    fi

    # Subversion 1.7 from Homebrew
    if [ -e "$(brew --prefix subversion17)" ] ; then
        export RUBYLIB=${brew_prefix}/lib/ruby:${RUBYLIB}
        export PERL5LIB="$(brew --prefix subversion17)"/Library/Perl/5.16:${PERL5LIB}
        export PYTHONPATH=${brew_prefix}/lib/svn-python:${PYTHONPATH}
    fi

    # Python 2.7 from Homebrew
#    if [ -e "$(brew --prefix python)" ]; then
#        export PYTHONPATH=""${brew_prefix}""/lib/python2.7/site-packages
#    fi

    # Ruby from Homebrew
    if [ -e "$(brew --prefix ruby)" ]; then
        export PATH=${brew_prefix}/opt/ruby/bin:${PATH}
    fi

    # Perl from Homebrew
#    if [ -e "$(brew --prefix perl)" ]; then
#    fi

    # Node from Homebrew
#    if [ -e "$(brew --prefix node)" ]; then
#    fi

    # Go from Homebrew
    if [ -e "$(brew --prefix go)" ]; then
        export PATH=$PATH:"$(brew --prefix go)"/libexec/bin
    fi

    # Boost.Build from Homebrew
    if [ -e "$(brew --prefix boost-build)" ]; then
        export BOOST_BUILD_PATH="$(brew --prefix boost-build)"/share
    fi

    # DocBook from Homebrew
    if [ -e "$(brew --prefix docbook)" ]; then
        export XML_CATALOG_FILES=${brew_prefix}/etc/xml/catalog
    fi

    # Android SDK from Homebrew
    if [ -e "$(brew --prefix android-sdk)" ]; then
        export ANDROID_SDK_ROOT=$(brew --prefix android-sdk)
    fi
fi

# Completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
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

# Python
if [ ! -z "$(which python 2> /dev/null)" ]; then
    export PATH="$(python -c 'import site ; print site.USER_BASE')/bin":${PATH}
fi

# Ruby
if [ ! -z "$(which ruby 2> /dev/null)" ] && [ ! -z "$(which gem 2> /dev/null)" ]; then
    export PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin":${PATH}
fi

# Node.js
if [ ! -z "$(which node 2> /dev/null)" ]; then
    export PATH="${HOME}"/.node_modules/bin:${PATH}
    export MANPATH="${HOME}"/.node_modules/share/man:${MANPATH}
    export NODE_PATH="${HOME}"/.node_modules/lib/node_modules:${NODE_PATH}
fi

# Go
if [ ! -z "$(which go 2> /dev/null)" ]; then
    export PATH="${HOME}"/opt/local/src/go/bin:${PATH}
fi

# Emacs
if [ ! -z "$(which emacsclient 2> /dev/null)" ]; then
    export ALTERNATE_EDITOR=
    export EDITOR="emacsclient -a vi"
fi

# never use ccache, no matter what
export CCACHE_DISABLE=""

# local bashrc
if [ -e "${HOME}"/.bashrc.local ]; then
    source "${HOME}"/.bashrc.local
fi
