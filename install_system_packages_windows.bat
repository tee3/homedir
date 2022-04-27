@echo off
rem
rem Install interesting packages for Windows.
rem
rem This assumes that the current user is the user used to install
rem packages and has the proper administrator privileges.

winget import install_system_packages_windows.json
winget upgrade --all
