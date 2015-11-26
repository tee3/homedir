@echo off
rem
rem Set up a home directory on a Windows system.

setlocal

set dotfiledirs=dotfiles

rem requires running form the root of the dotfiles directory
if not exist install.bat (
    echo must be run from the root of the dotfiles directory
    exit /b 1
)

rem requires HOME.
if "%HOME%" == "" (
    echo HOME is not set, aborting
    exit /b 1
)

set machine=windows

rem create ~/opt/local if desired
if not exist "%HOME%"\opt (
if not exist "%HOME%"\opt\local (
    set /p yn="create ~/opt/local (y/n): "
    if "%yn%" == "y" (
        mkdir "%HOME%"\opt\local\bin
        mkdir "%HOME%"\opt\local\include
        mkdir "%HOME%"\opt\local\lib
        mkdir "%HOME%"\opt\local\man
        mkdir "%HOME%"\opt\local\mnt
        mkdir "%HOME%"\opt\local\share
        mkdir "%HOME%"\opt\local\src

        rem populate ~/opt/local if it exists and desired
        echo nothing installed to ~/opt/local by default
    )
)
)

rem requires stow
rem @todo does not require stow, implemented below

rem attempt to stow the dotfiles directory, clean up if fails.
if "" == "" (
    rem allow user to clean up existing files
    for %%d in (%dotfiledirs%) do (
        pushd %%d
        for %%f in (*) do (
            if not exist "%HOME%\%%f" (
                copy /-y "%%f" "%HOME%\%%f"
            )
            if exist "%HOME%\%%f" (
                if not "%%f" == "%HOME%\%%f" (
                    fc /t "%%f" "%HOME%\%%f"
                    if ERRORLEVEL 1 (
                        set /p yn="%%f is different than %HOME%\%%f.  Overwrite anyway (y/n)?: "
                        if "%yn%" == "y" (
                            copy /-y "%%f" "%HOME%\%%f"
                        )
                    )
                )
            )
        )
        popd
    )

    rem @todo check if all files are present and identical
    if "0" == "1" (
        echo error^: some targets could not be linked to home directory.
        exit /b 1
    )
)

rem ask user for name and email address
set name=
set email=

if not "%name%" == "" (
if not "%email%" == "" (
    set /p yn="use default '%name% <%email%>' (y/n): "
    if "%yn%" == "n" (
        set name=
        set email=
    )
)
)

if "%name%" == "" (
if "%email%" == "" (
    set /p yn="Do you want to configure a default name and email address (y/n): "
    if "%yn%" == "y" (
        set /p s="Enter the user's full name (%name%): "
        if not "%s%" == "" (
            set name=%s%
        )
        set /p s="Enter the user's email address (%email%): "
        if not "%s%" == "" (
            set email=%s%
        )
        set /p yn="use '%name% <%email%>' (y/n): "
        if "%yn%" == "n" (
            set name=
            set email=
        )
    )
)
)

rem ask to install any services
echo warning^: services not implemented

rem set up machine-specific ~/.bashrc
if not exist "%HOME%"\.bashrc.local (
    echo ~/.bashrc.local is used for machine-specific bash settings.
    type NUL > "%HOME%"\.bashrc.local
)

rem configure git
set git=git
if not "%git%" == "" (
    rem set up machine-specific ~/.gitconfig
    if not exist "%HOME%"\.gitconfig.machine (
        echo ~/.gitconfig.machine is used for machine-specific settings to .gitconfig.
        type NUL > "%HOME%"\.gitconfig.machine
    )

    rem set up a credential helper
    if "%machine%" == "windows" (
        "%git%" config -f "%HOME%"\.gitconfig.machine credential.helper 'winstore'
    )

    rem set up user-specific ~/.gitconfig
    if not exist "%HOME%"\.gitconfig.user (
        echo ~/.gitconfig.user is used for user-specific settings to .gitconfig.
        type NUL > "%HOME%"\.gitconfig.user
    )

    rem configure user name and email for git
    set git_name=
    set git_email=

    rem if not set, suggest user name and email from global git config
    if "%git_name%" == "" (
    if "%git_email%" == "" (
        rem get user and email from git config
        rem set proposed_name=$(${git} config --global user.name)
        set proposed_name=
        rem set proposed_email=$(${git} config --global user.email)
        set proposed_email=

        rem @todo should be OR not AND
        if not "%proposed_name%" == "" (
        if not "%proposed_email%" == "" (
            set /p yn="use current global user information '%proposed_name% <%proposed_email%>' for git (y/n): "
            if "%yn%" == "n" (
                set git_name=%proposed_name%
                set git_email=%proposed_email%
            )
        )
        )
    )
    )

    rem if not set, suggest user name and email from user-specific git config
    if "%git_name%" == "" (
    if "%git_email%" == "" (
        rem get user and email from git config
        rem set proposed_name=$(${git} config -f %HOME%\.gitconfig.user user.name)
        set proposed_name=
        rem set proposed_email=$(${git} config -f %HOME%\.gitconfig.user user.email)
        set proposed_email=

        rem @todo should be OR not AND
        if not "%proposed_name%" == "" (
        if not "%proposed_email%" == "" (
            set /p yn="use current user-specific user information '%proposed_name% <%proposed_email%>' for git (y/n): "
            if "%yn%" == "n" (
                set git_name=%proposed_name%
                set git_email=%proposed_email%
            )
        )
        )
    )
    )

    rem if not set, suggest default user name and email
    if "%git_name%" == "" (
    if "%git_email%" == "" (
        set proposed_name=%name%
        set proposed_email=%email%

        rem @todo should be OR not AND
        if not "%proposed_name%" == "" (
        if not "%proposed_email%" == "" (
            set /p yn="use default '%proposed_name% <%proposed_email%>' for git (y/n): "
            if "%yn%" == "n" (
                set git_name=%proposed_name%
                set git_email=%proposed_email%
            )
        )
        )
    )
    )

    rem if not set, ask the user for name
    if "%git_name%" == "" (
        set /p git_name="Enter git user name: "
    )
    if "%git_email%" == "" (
        set /p git_email="Enter git user email: "
    )

    rem set the user-specific git config and clear the global git config
    rem @todo shuold be OR not AND
    if not "%git_name%" == "" (
    if not "%git_email%" == "" (
        set /p yn="setting user-specific user information to '%git_name% <%git_email%>' for git (y/n): "
        if "%yn%" == "y" (
            rem set user name/email in user-specific config
            "%git%" config -f "%HOME%"\.gitconfig.user user.name "%git_name%"
            "%git%" config -f "%HOME%"\.gitconfig.user user.email "%git_email%"

            rem if present, clear user in global git config
            "%git%" config --global --remove-section user
        )
    )
    )
)

rem configure mercurial
echo warning^: mercurial not implemented

rem configure emacs
echo warning^: emacs not fully implemented

if not exist "%HOME%"\.emacs.machine.el (
    echo ~/.emacs.machine.el is used for machine-specific settings to .emacs.
    type NUL > "%HOME%"\.emacs.machine.el
    echo ;;; package --- Machine-specific Emacs initialization. >> "%HOME%"\.emacs.machine.el
    echo. >> "%HOME%"\.emacs.machine.el
    echo ;;; Commentary^: >> "%HOME%"\.emacs.machine.el
    echo. >> "%HOME%"\.emacs.machine.el
    echo ;;; Code^: >> "%HOME%"\.emacs.machine.el
    echo. >> "%HOME%"\.emacs.machine.el
    echo ^(provide ^'.emacs.machine^) >> "%HOME%"\.emacs.machine.el
    echo. >> "%HOME%"\.emacs.machine.el
    echo ;;; .emacs.machine.el ends here >> "%HOME%"\.emacs.machine.el
)

if not exist "%HOME%"\.emacs.user.el (
    echo ~/.emacs.user.el is used for user-specific settings to .emacs.
    type NUL > "%HOME%"\.emacs.user.el
    echo ;;; package --- User-specific Emacs initialization. >> "%HOME%"\.emacs.user.el
    echo. >> "%HOME%"\.emacs.user.el
    echo ;;; Commentary^: >> "%HOME%"\.emacs.user.el
    echo. >> "%HOME%"\.emacs.user.el
    echo ;;; Code^: >> "%HOME%"\.emacs.user.el
    echo. >> "%HOME%"\.emacs.user.el
    echo ^(provide ^'.emacs.user^) >> "%HOME%"\.emacs.user.el
    echo. >> "%HOME%"\.emacs.user.el
    echo ;;; .emacs.user.el ends here >> "%HOME%"\.emacs.user.el
)

rem ask to install python packages
set /p yn="Install Python packages? (y/n)?: "
if "%yn%" == "y" (
    call install_python_packages.bat
    if ERRORLEVEL 1 (
        echo warning: failed to install Python packages.
    )
)

rem ask to install ruby packages
set /p yn="Install Ruby packages? (y/n)?: "
if "%yn%" == "y" (
    call install_ruby_packages.bat
    if ERRORLEVEL 1 (
        echo warning: failed to install Ruby packages.
    )
)

rem ask to install node packages
set /p yn="Install Node packages? (y/n)?: "
if "%yn%" == "y" (
    call install_node_packages.bat
    if ERRORLEVEL 1 (
        echo warning: failed to install Node packages.
    )
)

rem ask to install go packages
set /p yn="Install Go packages? (y/n)?: "
if "%yn%" == "y" (
    call install_go_packages.bat
    if ERRORLEVEL 1 (
        echo warning: failed to install Go packages.
    )
)
