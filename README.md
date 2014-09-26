# homedir

This directory contains both dot files to populate that home directory
and scripts to set up a home directory and packages.

This directory is intended to be tracked using git and shared across
multiple machines and so should be designed to work well across
different types of Unix systems.

To set up a new system or update an existing system for a user, run
the following commands when logged in as that user.

```
$ ./install
```

To install system packages (for OS X via Homebrew only for now), run
the following script as the administrator of the system.

```
$ ./install_system_packages_osx
```

# rationale

This is a very simple way of keeping home directories synchronized
across systems.  This was the easiest approach to getting something
going without learning a lot of new systems.

At some point, some of the more complex ways of doing this might
become useful.

# requirements

The `install` script must be run from this directory and the HOME
environment variable must be set properly.

* `sh`
* `stow`
* `diff`

# install

The `install` script checks for the requirements and then helps the
user set up a home directory.  There is special support for features
that require it.

## support for ~/opt/local

The `install` script will build a directory structure at ~/opt/local
if it does not exist.

In the future, this may also be populated.

## support for git

The `~/.gitconfig` file includes a file named `~/.gitconfig.user`
designed for git configuration parameters that are user-specific.

The install script will migrate the user name/email from
`~/.gitconfig` to `~/.gitconfig.user` as required.

## support for installing system packages

The `install_system_packages_osx` script will install required
packages for OS X.

There are a few issues with the current implementation.

1. This support is very preliminary as it only supports OS X vis
   Homebrew.  Supporting Linux is a little harder since there one
   requires `sudo` privileges, which may not always be available.
   There is some possibility in the Linuxbrew system, but it is
   probably not mature enough at this point.

2. This really should be generalized a bit since packages required for
   work are the same regardless of which system you are on.  A package
   list with a script for each system that processes the list and
   turns it into commands to Homebrew, `apt-get`, `yum`, etc. would be
   an interesting approach.

## support for python packages

Python packages are installed using the user protocol and are defined
in a requirements file (`python-packages.txt`) defines the installed
Python packages.

## support for ruby packages

Ruby gems are installed using the user protocol and a Gemfile
(`ruby-packages.gemfile`) defines the installed Ruby packages.

## support for node.js packages

Node.js modules are installed to the user's home directory under
`~/.node_modules` and a text file (`node-packages.txt`) defines the
installed Node.js modules.
