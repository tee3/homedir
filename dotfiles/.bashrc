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

    # Emacs.app from Homebrew
    if [ -e "$(brew --prefix emacs)" ]; then
        #alias Emacs.app="emacsclient -c -n"
        #alias Emacs.app="emacsclient -c -n -a open $(brew --prefix emacs)/Emacs.app"
        alias Emacs.app="open $(brew --prefix emacs)/Emacs.app"
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
#    if [ -e "$(brew --prefix go)" ]; then
#        export PATH=$PATH:"$(brew --prefix go)"/libexec/bin
#    fi

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
if [ -d ~/opt/local/bin ]; then
    export PATH=~/opt/local/bin:"${PATH}"
    export LD_LIBRARY_PATH=~/opt/local/lib
    export DYLD_LIBRARY_PATH=~/opt/local/lib
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
if [ ! -z "$(which ruby 2> /dev/null)" -a ! -z "$(which gem 2> /dev/null)" ]; then
    export PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin":${PATH}
fi

# Node.js
if [ ! -z "$(which node 2> /dev/null)" ]; then
    export PATH=~/.node_modules/bin:${PATH}
fi

# Go
if [ ! -z "$(which go 2> /dev/null)" ]; then
    export GOPATH=~/Development/go:${GOPATH}
    export PATH=~/Development/go/bin:${PATH}
fi

# Cappuccino
if [ -e ~/opt/local/narwhal ]; then
    export NARWHAL_ENGINE=jsc
    export PATH=~/opt/local/narwhal/bin:${PATH}
    export CAPP_BUILD=~/opt/local/src/cappuccino/Build
fi

# Emacs
if [ ! -z "$(which emacsclient 2> /dev/null)" ]; then
    export ALTERNATE_EDITOR=
    export EDITOR=emacsclient
fi

# manage ssh-agent
if [ -x /usr/bin/keychain ]; then
    eval "$(/usr/bin/keychain --eval --quiet --nogui)"
fi

# never use ccache, no matter what
export CCACHE_DISABLE=""

# local bashrc
if [ -e ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
