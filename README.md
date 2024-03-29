# homedir

This project contains an approach to maintain several systems with a
minimum of fuss.  To accomplish this, there are scripts to install
system packages (if required), set up a home directory for a user, and
install user-specific packages.  Configurations for many programs are
installed by default and some programs are handled specially.

This supports all UNIX and Windows platforms.  Other platforms may or
may not work depending on their approach to user configuration and
support for Python.

The home directory is intended to be tracked using git and shared
publicly.  It is intended to be used unchanged across multiple
machines and so should be designed to work well across different types
of systems that support Python and the various programs.  Sensitive
information is provided for by including hooks to local files that are
are not included in the shared repository.

# rationale

Keeping the configuration of several systems consistent is
challenging.  There are some high-level tools for doing so, but are
complicated to set up.  This intends to be a fairly straightforward
approach to the problem.

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
* `~/opt/local`
* user-installable programs
* user services (launchd, systemd)
* special support for Windows `cmd`

# supported systems

* macOS
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

### macos

* Homebrew
* administrator privileges (but not `sudo`)

### windows

* administrator privileges
* Developer mode enabled

## system

* `administrator` user

### linux

* `yum`- or `apt-get`-based Linux system
* `sudo`

### macos

* Homebrew
* administrator privileges (but not `sudo`)

### windows

* Administrator privileges
* Developer mode enabled

## user

* `python`
* `stow` (except on Windows)

For installing user services, the following programs are required.

* `launchctl` for macOS
* `systemctl` for Linux

To configure some useful programs, those programs must exist on the
system.

* `bash`
* `zsh`
* `git`
* `mercurial`
* `emacs`
* `python`
* `ruby`
* `rust`
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

``` shell
login: root
password: ************
```

``` shell
yum install sudo
usermod administrator -a -G wheel
exit
```

From the login terminal of the system, log in as `administrator` and
then install `git`, clone the `tee3/homedir` repository and install
the system packages.  At the end of this process, the machine will
reboot, so make sure there is no one else logged in.

``` shell
login: administrator
password: ************
```

``` shell
sudo yum install git
git clone https://github.com/tee3/homedir.git ~/Development/homedir
cd ~/Development/homedir
./install_bootstrap_packages_fedora
sudo shutdown -r now
```

## debian

From the login terminal of the system, log in as `root` and then
install `sudo` and give `administrator` `sudo` privileges.

``` shell
login: root
password: ************
```

``` shell
apt-get install sudo
adduser administrator sudo
exit
```

From the login terminal of the system, log in as `administrator` and
then install `git`, clone the `tee3/homedir` repository and install
the system packages.  At the end of this process, the machine will
reboot, so make sure there is no one else logged in.

``` shell
login: administrator
password: ************
```

``` shell
sudo apt-get install git
git clone https://github.com/tee3/homedir.git ~/Development/homedir
cd ~/Development/homedir
./install_bootstrap_packages_debian
sudo shutdown -r now
```

## macos

Install Xcode and the Xcode Command-Line Tools, as well as Homebrew,
while logged in to the graphical system as `administrator`.  From a
Terminal.app window install the system packages.  At the end of this
process, the machine will reboot, so make sure there is no one else
logged in.

``` shell
git clone https://github.com/tee3/homedir.git ~/Development/homedir
cd ~/Development/homedir
./install_bootstrap_packages_macos
sudo shutdown -r now
```

## windows

Go to Settings->Update & Security->For developers->Developer Mode and
enable it.  Install "App Installer" from the Microsoft Store, and the
Windows Package Manager CLI (`winget-cli`) from
https://github.com/microsoft/winget-cli.

* Boost.Build from Boost C++ Libraries 1.81.0

  * Install from source.

  * Download `boost_1_81_0.zip` to `C:\Boost\src\boost_1_81_0.zip`.

  * Extract to `C:\Boost\src\boost_1_81_0`.

  * Install Boost.Build to `C:\boost-build`.

    ```
    cd C:\Boost\src\boost_1_81_0\tools\build
    bootstrap.bat
    .\b2 install
    ```

* Boost C++ Libraries 1.81.0

  * Install from source (this will take a very long time).

  * Download `boost_1_81_0.zip` to `C:\Boost\src\boost_1_81_0.zip`.

  * Extract to `C:\Boost\src\boost_1_81_0`.

  * Install versioned Boost C++ Libraries to `C:\Boost`.

    ```
    cd C:\Boost\src\boost_1_81_0
    bootstrap.bat
    .\b2 --layout=system variant=release address-model=64 install
    ```

From a `cmd` window install the system packages.  At the end of this
process, the machine will reboot, so make sure there is no one else
logged in.

``` batchfile
winget install --exact --id Git.Git
git clone https://github.com/tee3/homedir.git C:\Users\administrator\Development\homedir
cd C:\Users\administrator\Development\homedir
install_bootstrap_packages_windows
shutdown /r
```

## windows subsystem for linux

This is a Ubunutu-based command-line system within Windows 10
Anniversary Edition.  As such, it is supported as if it were a Debian
system above.

1. Enable the **Developer Mode** radio button in **Settings->Update &
   security->For developers**.

2. Enable the **Windows Subsystem for Linux** in **Control
   Panel->Programs->Turn Windows features on or off** and follow the
   instructions and reboot.

3. Run `bash` within a **Command Prompt** and agree to install Ubuntu.

4. Enter `administrator` when asked for a user.

5. Exit the **Command Prompt**.

6. Run **Bash on Ubuntu for Windows** from the **Start Menu**, which
   will log in as `administrator`.

7. Add a user `USER` by running the following command.

   ``` shell
   sudo /usr/sbin/adduser USER
   ```

8. Exit the **Bash on Ubuntu for Windows** shell.

From the login terminal of the system, log in as `administrator` by
running **Bash on Ubuntu for Windows** and then install `git`, clone
the `tee3/homedir` repository and install the system packages.

``` shell
sudo apt-get install git
git clone https://github.com/tee3/homedir.git ~/Development/homedir
cd ~/Development/homedir
./install_bootstrap_packages_debian
```

Note that Windows Subsystem for Linux is supported as it is a
`apt-get`-based system.  While this is a true Linux system, there are
still some limitations.  It is based on Ubuntu (and an earlier version
of Debian), and so runs some older packages.  It also seems as if the
`init` system is not run as expected.

The following provides some *ad-hoc* workarounds for these
limitations.

1. To switch to the `administrator` user, run the `lxrun` command as
   shown below.

   ``` batchfile
   lxrun /setdefaultuser administrator
   ```

2. To update the package databases, run the `lxrun` command as shown
   below.

   ``` batchfile
   lxrun /update
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

The system install scripts are written in the least-common denominator
language for the system on which it runs.

## fedora

To install system packages for Fedora-based systems (via `yum`), run
the following script as a user with `sudo` permission.

``` shell
./install_system_packages_fedora
```

## debian

To install system packages for Debian-based systems (via `apt-get`),
run the following script as a user with `sudo` permission.

``` shell
./install_system_packages_debian
```

## macos

To install system packages for macOS (via Homebrew), run the following
script as the administrator of the system.  Note that this does not
use `sudo` as Homebrew does not require it.

``` shell
./install_system_packages_macos
```

## windows

To install system packages for Windows, run the following script as
the administrator of the system.

``` batchfile
install_system_packages_windows
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

``` shell
python3 install
```

## Support for sensitive information

Each supported feature provides `local`, `machine`, or `user`-specific
files for configuration local to a particular machine or user that is
not appropriate to put on a public server.  This includes things like
names, email addresses, keys, certificates, and other sensitive
information.

## support for `sh`

This contains support for the Bourne Shell (sh) via the `~/.profile`
file.

The configuration system generates a `~/.profile.local` file for local
configuration.  It is initially empty.

## support for `bash`

This contains support for the Bourne Again Shell (Bash) by including
`~/.bash_profile`, `~/.bashrc`, `~/.bash_logout`, and
`~/.bashrc.local` files.  This builds off the Bourne Shell support.

The configuration system generates a `~/.bashrc.local` file for local
configuration.  It is initially empty.

## support for `zsh`

This contains support for the Z Shell (bash) by including
`~/.zprofile` and `~/.zshrc` files.  This builds off the Bourne Shell
support.

The configuration system generates a `~/.zshrc.local` file for local
configuration.  It is initially empty.

## support for `cmd`

This contains some minimal support for `cmd` such that HOME is set
properly and development tools are properly set up.  This models how
`bash` is initialized by adding a `~/.cmdrc.bat` file (and
`~/.cmdrc.local.bat` file) that is executed on starting `cmd`.

The configuration system generates a `~/.cmdrc.local.bat` file for
local configuration.  It is initially empty.

## support for emacs

This contains a `~/.emacs` file, which installs and configures Emacs
packages automatically via `use-package` and `package`.

The configuration system generates `~/.emacs.machine.el` and
`~/.emacs.user.el` for local machine and user configuration.  These
files initially contain only boilerplate for Emacs Lisp file.  The
configuration system optionally will provide the user with suggestions
to set up these files to properly set the system's name and the user's
name and email address since these are often detected incorrectly by
Emacs.

There is a also a very minimal Emacs configuration file named
[~/.emacs.minimal.el](dotfiles/.emacs.minimal.el).  This can be
installed to `~/.emacs` manually on systems that do not require a full
homedir installation.

It can also be used to experiment with a minimally-configured Emacs.
Run the following command to use Emacs with the minimal Emacs
configuration.

```shell
emacs -nw -q -l ~/.emacs.minimal.el
```

This is not exactly the same as running Emacs with `~/.emacs`, but it
is close enough for experimentation.

## support for ssh

This includes `~/.ssh/config` file to configure SSH.  This is intended
to be portable across all systems including Windows.

The `~/.ssh/config` file includes all files in the directory
`~/.ssh/config.d`.  This is intended for configuration parameters that
are sensitive and should not be shared on a public server.

The user is required to move the current contents of `~/.ssh/config`
before migrating to this approach since it is a fairly complicated
process.  One approach is to move the existing `~/.ssh/config` file to
a file in `~/.ssh/config.d`.  This will override all settings in the
shared `~/.ssh/config` file.

## support for git

This includes `~/.gitconfig`, `~/.gitignore`, and `~/.gitattributes`
files to configure Git.  This is intended to be portable across all
systems including Windows.

The `~/.gitconfig` file includes files named `~/.gitconfig.machine`
and `~/.gitconfig.user` for machine-specific and user-specific
configuration parameters.  This is intended for configuration
parameters that are sensitive and should not be shared on a public
server.

The install script will migrate the user name/email from
`~/.gitconfig` to `~/.gitconfig.user` as required.

## support for `~/opt/local`

The `install` script will build a directory structure at `~/opt/local`
if it does not exist.

This is populated with source packages described below.

## support for python packages

Python packages are installed using the user protocol and a
requirements file defines the installed Python packages.

See [install_python_packages.txt](./install_python_packages.txt) for a
list of installed Python packages.

## support for ruby packages

Ruby gems are installed using the user protocol and a Gemfile defines
the installed Ruby packages.

See [install_ruby_packages.gemfile](./install_ruby_packages.gemfile)
for a list of installed Ruby packages.

## support for rust packages

Rust programs are using installed for the local user, which is the
default.

See [install_rust_packages.txt](./install_rust_packages.txt) for a
list of installed Rust packages.

## support for node.js packages

Node.js modules are installed to the user's home directory under
`~/.node_modules` and a text file defines the installed Node.js
modules.

See the [install_node_packages.txt](./install_node_packages.txt) for a
list of installed Node.js packages.

Note that this might be done more cleanly by using a `package.json`
file and the `npm` install machinery for it directly instead of a text
file of `npm` package names.  Unfortunately, I have not figured out
how to do this yet.

## support for go packages

Go packages are installed to the user's home directory under `~/.go`
and a text file defines the installed Go packages.

See the [install_go_packages.txt](./install_go_packages.txt) for a
list of installed Go packages.

## support for source packages

There is a script to support installing packages that are not
supported by a standard package manager or require special
consideration.

* `tee3-c-style`
* `msvc-c-style`
* `git-svn-update-externals`
* `boost`

See the bottom of the [script](./install_source_packages) for an more
up-to-date list of source packages.

## support for boost versions

There is a script to install any version of Boost C++ Libraries into a
directory in the `~/opt/local/src/boost` directory.

See the [script](./install_boost) for the details.
