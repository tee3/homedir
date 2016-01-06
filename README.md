# homedir

This project contains a system to set up a system to a usable state
for my purposes.  This includes installing system packages (if
required) as well as setting up a home directory and user-specific
packages.

This is intended to be tracked using git and shared across multiple
machines and so should be designed to work well across different types
of systems that support Python and the various programs.

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
* Windows

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

### windows

* administrator privileges

## system

* `administrator` user

### linux

* `yum`- or `apt-get`-based Linux system
* `sudo`

### os x

* Homebrew
* administrator privileges (but not `sudo`)

### windows

* Adminsitrator privileges

## user

The `HOME` environment variable must be set properly.  Note that this
is almost always true in Unix environments, but may not be correct for
some Unix emulation layers such as MSYS or Cygwin.

* `python`
* `stow` (except on Windows)

For installing user services, the following programs are required.

* `launchctl` for OS X
* `systemctl` for Linux

To configure some useful programs, those programs must exist on the
system.

* `bash`
* `git`
* `mercurial`
* `emacs`
* `python`
* `ruby`
* `node.js`
* `go`

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
$ git clone https://github.com/tee3/homedir ~/Development/homedir
$ cd ~/Development/homedir
$ ./install_system_packages_osx
$ sudo shutdown -r now
```

## windows

There is very limited support for installing system packages under
Windows and such is a manual process.  Administrator privileges is
required in order to install programs for all users.

1. Log in to the graphical system as a user with Administrator
   privileges.

2. Install Git For Windows and allow it to add itself to the PATH,
   assuming it is installed to `C:\Git`.

3. Install Python 2.7 and allow it to add itself to the PATH, assuming
   it is instsalled to `C:\Python27`.

4. Install Visual C++ and the Visual C++ Build Tools.

5. (Optional) Install Ruby and allow it to add itself to the PATH,
   assuming it is installed to `C:\Ruby22-x64`.

5. (Optional) Install Go and allow it to add itself to the PATH,
   assuming it is installed to `C:\Go`.

5. (Optional) Install Node.JS and allow it to add itself to the PATH,
   installing to `C:\nodejs`.

5. From a `cmd` window, install the system packages.

```
C:> git clone https://github.com/tee3/homedir C:\Users\administrator\Development\homedir
C:> cd C:\Users\administrator\Development\homedir
C:> install_system_packages_windows
```

7. At the end of this process, reboot the machine.

# system

Installing system packages should be done as necessary as it updates
the system as well as installs system packages added after the initial
bootstrap of the system.

NOTE: Installing system packages should really be generalized a bit
since packages required for work are the same regardless of which
system you are on.  A package list with a script for each system that
processes the list and turns it into commands to Homebrew, `apt-get`,
`yum`, etc. would be an interesting approach.

The system install scripts are written in the least-common denominator
language for the system on which it runs.

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

## windows

NOTE: Windows package support is lacking as there is no useful package
system for Windows yet.

To install system packages for Windows, run the following script as
the administrator of the system.

```
C:> install_system_packages_windows
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

Note that the `install` script and its supported scripts require
Python.

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
