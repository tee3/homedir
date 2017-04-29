@echo off

rem Note that PATH cannot be set within "if exists X ( )"

rem Add local optional to path
set CMDOPTLOCAL=%HOME%\opt\local
if exist "%CMDOPTLOCAL%" set PATH=%CMDOPTLOCAL%\bin;%PATH%

rem Git
set CMDGITROOT=C:\Git
if exist "%CMDGITROOT%" set PATH=%CMDGITROOT%\usr\bin;%PATH%

rem SSH
call start-ssh-agent

rem Python
set CMDPYTHONROOT=C:\Python27
if exist "%CMDPYTHONROOT%" set PATH=%CMDPYTHONROOT%;%CMDPYTHONROOT%\Scripts;%PATH%
rem @todo would be better if this used same approach as bash
if exist "%CMDPYTHONROOT%" set PATH=%HOME%\AppData\Roaming\Python\Scripts;%PATH%

rem Ruby
set CMDRUBYROOT=C:\Ruby23
rem @todo would be better if this used same approach as bash
if exist "%CMDRUBYROOT%" set PATH=%HOME%\.gem\ruby\2.3.0\bin;%PATH%

rem Node.js
set CMDNODEJSROOT=C:\nodejs
set CMDNPMPREFIX=%HOME%\.node_modules
if exist "%CMDNODEJSROOT%" set PATH=%CMDNPMPREFIX%\bin;%PATH%
if exist "%CMDNODEJSROOT%" set NODE_PATH=%CMDNPMPREFIX%\lib\node_modules:%NODE_PATH%

rem Go
set CMDGOROOT=C:\Go
if exist "%CMDGOROOT%" set PATH=%CMDOPTLOCAL%\src\go\bin;%PATH%

rem Emacs
set CMDEMACSROOT=C:\Emacs
if exist "%CMDEMACSROOT%" set PATH=%CMDEMACSROOT%\bin;%PATH%
if exist "%CMDEMACSROOT%" (
   set ALTERNATE_EDITOR=
   set EDITOR=emacsclient -a notepad.exe
)

rem local .cmdrc
if exist "%HOME%"\.cmdrc.local.bat (
   call "%HOME%"\.cmdrc.local.bat
)
