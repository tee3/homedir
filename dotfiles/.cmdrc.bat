@echo off

rem Note that PATH cannot be set within "if exists X ( )"

rem Add local optional to path
set CMDOPTLOCAL=%HOME%\opt\local
if exist "%CMDOPTLOCAL%" set PATH=%CMDOPTLOCAL%\bin;%PATH%

rem Git
set CMDGITROOT=C:\Git
if not exist "%CMDGITROOT%" echo Git is not installed at "%CMDGITROOT%".
if exist "%CMDGITROOT%" set PATH=%CMDGITROOT%\usr\bin;%PATH%

rem SSH
call start-ssh-agent

rem Python
set CMDPYTHONROOT=C:\Python27
if not exist "%CMDPYTHONROOT%" echo Python is not installed at "%CMDPYTHONROOT%".
if exist "%CMDPYTHONROOT%" set PATH=%CMDPYTHONROOT%;%CMDPYTHONROOT%\Scripts;%PATH%
rem @todo would be better if this used same approach as bash
if exist "%CMDPYTHONROOT%" set PATH=%HOME%\AppData\Roaming\Python\Scripts;%PATH%

rem Ruby
set CMDRUBYROOT=C:\Ruby24
if not exist "%CMDRUBYROOT%" echo Ruby is not installed at "%CMDRUBYROOT%".
rem @todo would be better if this used same approach as bash
if exist "%CMDRUBYROOT%" set PATH=%HOME%\.gem\ruby\2.4.0\bin;%PATH%

rem Node.js
set CMDNODEJSROOT=C:\nodejs
if not exist "%CMDNODEJSROOT%" echo NodeJS is not installed at "%CMDNODEJSROOT%".
set CMDNPMPREFIX=%HOME%\.node_modules
if exist "%CMDNODEJSROOT%" set PATH=%CMDNPMPREFIX%;%PATH%
if exist "%CMDNODEJSROOT%" set NODE_PATH=%CMDNPMPREFIX%\node_modules:%NODE_PATH%

rem Go
set CMDGOROOT=C:\Go
if not exist "%CMDGOROOT%" echo Go is not installed at "%CMDGOROOT%".
if exist "%CMDGOROOT%" set PATH=%HOME%\.go\bin;%PATH%

rem Emacs
set CMDEMACSROOT=C:\Program Files\Emacs
if not exist "%CMDEMACSROOT%" echo Emacs is not installed at "%CMDEMACSROOT%".
if exist "%CMDEMACSROOT%" set PATH=%CMDEMACSROOT%\x86_64\bin;%PATH%
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
