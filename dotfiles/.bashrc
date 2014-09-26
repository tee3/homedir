# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Homebrew setup
if [ -e /usr/local/bin/brew ]; then
    brew_prefix=$(/usr/local/bin/brew --prefix)

    export PATH=${brew_prefix}/bin:${brew_prefix}/sbin:${PATH}

    # Hunspell from Homebrew
    if [ -e "$(brew --prefix hunspell)" ]; then
        export DICTIONARY=en_US
    fi

    # tmux from Homebrew
    if [ -f "${brew_prefix}"/etc/bash_completion.d/tmux ]; then
        source "${brew_prefix}"/etc/bash_completion.d/tmux
    fi

    # Emacs.app from Homebrew
    if [ -e "$(brew --prefix emacs)" ]; then
        #alias Emacs.app="emacsclient -c -n"
        #alias Emacs.app="emacsclient -c -n -a open $(brew --prefix emacs)/Emacs.app"
        alias Emacs.app="open $(brew --prefix emacs)/Emacs.app"
    fi

    # Git from Homebrew
    if [ -f "${brew_prefix}"/etc/bash_completion.d/git-completion.bash ]; then
        source "${brew_prefix}"/etc/bash_completion.d/git-completion.bash
    fi
    if [ -f "${brew_prefix}"/etc/bash_completion.d/git-flow-completion.bash ]; then
        source "${brew_prefix}"/etc/bash_completion.d/git-flow-completion.bash
    fi
    if [ -f "${brew_prefix}"/etc/bash_completion.d/git-prompt.sh ]; then
        source "${brew_prefix}"/etc/bash_completion.d/git-prompt.sh
    fi
    if [ -f "${brew_prefix}"/etc/bash_completion.d/tig-completion.bash ]; then
        source "${brew_prefix}"/etc/bash_completion.d/tig-completion.bash
    fi

    # Hub from Homebrew
    if [ -f "${brew_prefix}"/etc/bash_completion.d/hub.bash_completion.sh ]; then
        source "${brew_prefix}"/etc/bash_completion.d/hub.bash_completion.sh
    fi

    # Subversion 1.7 from Homebrew
    if [ -f "${brew_prefix}"/etc/bash_completion.d/subversion ]; then
        source "${brew_prefix}"/etc/bash_completion.d/subversion
    fi

    if [ -e "$(brew --prefix subversion17)" ] ; then
        export RUBYLIB=${brew_prefix}/lib/ruby:${RUBYLIB}
        export PERL5LIB="$(brew --prefix subversion17)"/Library/Perl/5.16:${PERL5LIB}
        export PYTHONPATH=${brew_prefix}/lib/svn-python:${PYTHONPATH}
    fi

    # Python 2.7 from Homebrew
#    if [ -e "$(brew --prefix python)" ]; then
#        export PYTHONPATH="$(brew --prefix)"/lib/python2.7/site-packages
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
    PATH="$(python -c 'import site ; print site.USER_BASE')/bin":${PATH}
fi

# Ruby
if [ ! -z "$(which ruby 2> /dev/null)" -a ! -z "$(which gem 2> /dev/null)" ]; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin":${PATH}
fi

# Node.js
if [ ! -z "$(which node 2> /dev/null)" ]; then
    PATH=~/.node_modules/bin:${PATH}
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin":${PATH}
fi

# Emacs
if [ ! -z "$(which emacsclient 2> /dev/null)" ]; then
    export ALTERNATE_EDITOR=
    export EDITOR=emacsclient
fi

# Cappuccino
if [ -e ~/opt/local/narwhal ]; then
    export NARWHAL_ENGINE=jsc
    export PATH=~/opt/local/narwhal/bin:${PATH}
    export CAPP_BUILD=~/opt/local/src/cappuccino/Build
fi

# rtags
if [ -e ~/opt/local/bin/rdm ]; then
    # total hack for OS X, need one for Linux
    if [ -e /usr/local/lib/llvm-3.4/lib ]; then
        export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:/usr/local/lib/llvm-3.4/lib
    fi
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
