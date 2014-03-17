# home

This directory contains a script to set up a home directory as well as
dot files to populate that home directory.  This directory is intended
to be tracked using git and shared across multiple machines.

# rationale

This is a very simple way of keeping home directories synchronized
across systems.  This was the easiest approach to getting something
going without learning a lot of new systems.

At some point, some of the more complex ways of doing this might
become useful.

# requirements

The install script must be run from this directory and the HOME
environment variable must be set properly.

* sh
* stow
* diff

# install

The install script checks for the requirements and then helps the user
set up a home directory.  There is special support for features that
require it.

## support for ~/opt/local

The install script will build a directory structure at ~/opt/local if
it does not exist.

In the future, this may also be populated.

## support for git

The ~/.gitconfig file includes a file named ~/.gitconfig.user designed
for git configuration parameters that are user-specific.

The install script will migrate the user name/email from ~/.gitconfig
to ~/.gitconfig.user as required.
