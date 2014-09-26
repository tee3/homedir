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

To install packages (for OS X via Homebrew only for now), run the
following script as the administrator of the system.

```
$ ./install_packages_osx
```

To install Ruby packages for any system, run the following script as
the administrator of the system.

```
$ gem install bundler
$ bundle install --gemfile=ruby-packages.gemfile
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

## support for installing packages

The `install_packages_osx` script will install required packages for
OS X.

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

A Gemfile (`ruby-packages.gemfile`) defines the Ruby packages.

There are some outstanding issues with this approach.

1. Ruby is not checked in the `install` script.

2. There is no `gem` configuration file installed by the `install`
   script.

3. The packages are not installed in the `install` script.

4. This currently installs to the default location and therefore must
   be run as an appropriate user and with the appropriate permissions.
   If this can be done per-user in a sane way, it should be done that
   way.  This currently will require at least administrator access and
   a Homebrew ruby for OS X and `sudo` access for other Unix
   systems.  This is not good and could potentially be remedied, but
   making it work easily is a bit of a pain.
