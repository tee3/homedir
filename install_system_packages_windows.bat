@echo off
rem
rem Install interesting packages for Windows.
rem
rem This assumes that the current user is the user used to install
rem packages and has the proper administrator privileges.

set pm=choco
set pm_check=
set pm_update=
set pm_upgrade=%pm% upgrade
set pm_install=%pm% install -y
set pm_cleanup=

rem update choco
%pm_update%

rem upgrade existing packages
%pm_upgrade%

rem install packages for homedir installer
%pm_install% wget
%pm_install% stow
%pm_install% diffutils

rem install interpreters prior to other packages
%pm_install% python2
%pm_install% python3
%pm_install% ruby

rem install version control systems
%pm_install% git
rem %pm_install% mercurial
%pm_install% tortoisesvn

%pm_install% boost
%pm_install% boost-build

%pm_install% cmake

%pm_install% emacs

%pm_install% GitHub

%pm_install% go

%pm_install% nodejs

%pm_install% rust

%pm_install% vim
%pm_install% visualstudio2017-workload-vctools
