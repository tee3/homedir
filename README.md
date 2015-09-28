# homedir

This project contains a system to set up a Unix-based system to a
usable state for my purposes.  This includes installing system
packages (if required) as well as setting up a home directory and
user-specific packages.

This is intended to be tracked using git and shared across multiple
machines and so should be designed to work well across different types
of Unix systems.

# rationale

This is a very simple way of keeping configurations consistent across
systems.

# overview

## bootstrap

Bootstrapping a system involves making sure the `administrator` user
is present and satisfies the minimal requirements for an administrator
of the system.  It also ensures that required system packages are
installed.

## system

Installing system packages involves ensuring that the system is up to
date and all required packages are installed.

## user

* program configurations (dot files)
* ~/opt/local
* user-installable programs
* user services (launchd, systemd)

# supported systems

* OS X
* Linux

While the `install` portion of this system supports Cygwin- or
MSYS-based systems, the package managers for those systems are not
supported.

# requirements

The install family of scripts assumes that they are run from the root
of the `tee3/homedir` directory.

## bootstrap

* `administrator` user

### linux

* `yum`- or `apt-get`-based Linux system
* `root` access

### os x

* Homebrew
* administrator privileges (but not `sudo`)

## system

* `administrator` user

### linux

* `yum`- or `apt-get`-based Linux system
* `sudo`

### os x

* Homebrew
* administrator privileges (but not `sudo`)

## user

The `HOME` environment variable must be set properly.  Note that this
is almost always true in Unix environments, but may not be correct for
some Unix emulation layers such as MSYS or Cygwin.

* `sh`
* `stow`
* `diff`

# bootstrap

The process below assumes a system with a user named `administrator`
that may or may not yet have `sudo` privileges.

This is especially useful with a "minimal installation" Linux machine
since many packages are not installed by default.

## fedora

From the login terminal of the system, log in as `root` and then
install `sudo` and give `administrator` `sudo` privileges.

```
login: root
password: ************
# yum install sudo
# usermod administrator -a -G wheel
# exit
```

From the login terminal of the system, log in as `administrator` and
then install `git`, clone the `tee3/homedir` repository and install
the system packages.  At the end of this process, the machine will
reboot, so make sure there is no one else logged in.

```
login: administrator
password: ************
$ sudo yum install git
$ git clone https://github.com/tee3/homedir ~/Development/homedir
$ cd ~/Development/homedir
$ ./install_system_packages_fedora
$ sudo shutdown -r now
```

## debian

From the login terminal of the system, log in as `root` and then
install `sudo` and give `administrator` `sudo` privileges.

```
login: root
password: ************
# apt-get install sudo
# adduser administrator sudo
# exit
```

From the login terminal of the system, log in as `administrator` and
then install `git`, clone the `tee3/homedir` repository and install
the system packages.  At the end of this process, the machine will
reboot, so make sure there is no one else logged in.

```
login: administrator
password: ************
$ sudo apt-get install git
$ git clone https://github.com/tee3/homedir ~/Development/homedir
$ cd ~/Development/homedir
$ ./install_system_packages_debian
$ sudo shutdown -r now
```

## os x

Install Xcode and the Xcode Command-Line Tools, as well as Homebrew,
while logged in to the graphical system as `administrator`.  From a
`Terminal.app` window install the system packages.  At the end of this
process, the machine will reboot, so make sure there is no one else
logged in.

```
$ ./install_system_packages_osx
$ sudo shutdown -r now
```

# system

Installing system packages should be done as necessary as it updates
the system as well as installs system packages added after the initial
bootstrap of the system.

NOTE: Installing system packages should really be generalized a bit
since packages required for work are the same regardless of which
system you are on.  A package list with a script for each system that
processes the list and turns it into commands to Homebrew, `apt-get`,
`yum`, etc. would be an interesting approach.

## fedora

To install system packages for Fedora-based systems (via yum), run the
following script as a user with `sudo` permission.

```
$ ./install_system_packages_fedora
```

## debian

To install system packages for Debian-based systems (via apt-get), run
the following script as a user with `sudo` permission.

```
$ ./install_system_packages_debian
```

## os x

To install system packages for OS X (via Homebrew), run the following
script as the administrator of the system.  Note that this does not
use `sudo` as Homebrew does not require it.

```
$ ./install_system_packages_osx
```

# user

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

## support for emacs

Emacs packages are installed and configured automatically by the
included `~/.emacs` initialization file.
