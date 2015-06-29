# homedir

This directory contains both dot files to populate that home directory
and scripts to set up a home directory and packages.

This directory is intended to be tracked using git and shared across
multiple machines and so should be designed to work well across
different types of Unix systems.

# rationale

This is a very simple way of keeping home directories synchronized
across systems.  This was the easiest approach to getting something
going without learning a lot of new systems.

At some point, some of the more complex ways of doing this might
become useful.

# requirements

The `install` script must be run from this directory and the `HOME`
environment variable must be set properly.

* `sh`
* `stow`
* `diff`

# bootstrap

This assumes a bootstrapped system with a user named `administrator`
as an administrator of the machine.  This is especially useful with a
"minimal installation" Linux machine.

To install system packages for Fedora-based systems (via yum), run the
following script as a user with `sudo` permission.

```
$ ./install_system_packages_fedora
```

To install system packages for Debian-based systems (via yum), run the
following script as a user with `sudo` permission.

```
$ ./install_system_packages_debian
```

To install system packages for OS X (via Homebrew), run the following
script as the administrator of the system.

```
$ ./install_system_packages_osx
```

## fedora

1. log in as `root`
2. install `sudo`
3. `usermod administrator -a -G wheel`
4. log out
5. log in to `administrator`
6. `sudo yum install git`
7. `git clone https://github.com/tee3/homedir ~/Development/homedir`
8. `cd ~/Development/homedir`
9. `./install_system_packages_debian`

## debian

1. log in as `root`
2. install `sudo`
3. `adduser administrator sudo`
4, log out
5. log in to `administrator`
6. `sudo apt-get install git`
7. `git clone https://github.com/tee3/homedir ~/Development/homedir`
8. `cd ~/Development/homedir`
9. `./install_system_packages_debian`

## os x

1. install Xcode
2. install Xcode command-line tools
3. `./install_system_pacakges_osx`

# install

To set up a new system or update an existing system for a user, run
the following commands when logged in as that user.  Note that all
system packages should be installed prior to the `install` script via
the bootstrap procedure above so all support applications are properly
set up.

The `install` script checks for the requirements and then helps the
user set up a home directory.  There is special support for features
that require it.  It is not recommended to install the `~/opt/local`
directories or the scripting language tools for the `administrator`
user.

```
$ ./install
```

## support for `~/opt/local`

The `install` script will build a directory structure at `~/opt/local`
if it does not exist.

In the future, this may also be populated.

## support for git

The `~/.gitconfig` file includes a file named `~/.gitconfig.user`
designed for git configuration parameters that are user-specific.

The install script will migrate the user name/email from
`~/.gitconfig` to `~/.gitconfig.user` as required.

## support for installing system packages

This system has direct support for OS X and Linux (both Fedora- and
Debian-based).

NOTE: Installing system packages should really be generalized a bit
since packages required for work are the same regardless of which
system you are on.  A package list with a script for each system that
processes the list and turns it into commands to Homebrew, `apt-get`,
`yum`, etc. would be an interesting approach.

### requirements for os x

- administrator privileges (not `sudo` or `root` permissions)

### requirements for linux

- `sudo` or `root`

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
