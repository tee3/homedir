@echo off

rem Note that PATH cannot be set within "if exists X ( )"

rem Add local optional to path
set CMDOPTLOCAL=%HOME%\opt\local
if exist "%CMDOPTLOCAL%" set PATH=%CMDOPTLOCAL%\bin;%PATH%

rem SSH
ssh-agent

rem Python
FOR /f "delims=" %%A IN ('python3 -c "import site; print(site.USER_BASE)"') DO set "PATH=%PATH%;%%A\Python38\Scripts"

rem Ruby
FOR /f "delims=" %%A IN ('ruby -r rubygems -e "puts Gem.user_dir"') DO set "PATH=%PATH%;%%A\bin"

rem Node.js
set CMDNPMPREFIX=%HOME%\.node_modules
if exist "%CMDNODEJSROOT%" set PATH=%CMDNPMPREFIX%;%PATH%
if exist "%CMDNODEJSROOT%" set NODE_PATH=%CMDNPMPREFIX%\node_modules:%NODE_PATH%

rem Go
if exist "%CMDGOROOT%" set PATH=%HOME%\.go\bin;%PATH%

rem @todo this needs to be set up
rem Rust

rem @todo this needs to be set up
rem Lua

rem Emacs
set CMDEMACSROOT=C:\Program Files\Emacs
if not exist "%CMDEMACSROOT%" echo Emacs is not installed at "%CMDEMACSROOT%".
if exist "%CMDEMACSROOT%" set PATH=%CMDEMACSROOT%\emacs-28.2\bin;%PATH%
if exist "%CMDEMACSROOT%" (
   set ALTERNATE_EDITOR=
   set EDITOR=emacsclient -a notepad.exe
)

rem Boost.Build
set BOOSTBUILDPREFIX=C:\boost-build
if not exist "%BOOSTBUILDPREFIX%" echo Boost.Build is not installed at "%BOOSTBUILDPREFIX%"
if exist "%BOOSTBUILDPREFIX%" set PATH=%BOOSTBUILDPREFIX%\bin;%PATH%
if exist "%BOOSTBUILDPREFIX%" set BOOST_BUILD_PATH=%BOOSTBUILDPREFIX%

rem Boost
set BOOSTPREFIX=C:\Boost
if not exist "%BOOSTPREFIX%" echo Boost is not installed at "%BOOSTPREFIX%"

rem local .cmdrc
if exist "%HOME%"\.cmdrc.local.bat (
   call "%HOME%"\.cmdrc.local.bat
)
