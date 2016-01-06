@echo off

REM Note that PATH cannot be set within "if exists X ( )"

REM Add local optional to path
set CMDOPTLOCAL=%HOME%\opt\local
if exist "%CMDOPTLOCAL%" set PATH=%CMDOPTLOCAL%\bin;%PATH%

REM Python
set CMDPYTHONROOT=C:\Python27
if exist "%CMDPYTHONROOT%" set PATH=%CMDPYTHONROOT%;%CMDPYTHONROOT%\Scripts;%PATH%
REM @todo would be better if this used same approach as bash
if exist "%CMDPYTHONROOT%" set PATH=%HOME%\AppData\Roaming\Python\Scripts;%PATH%

REM Ruby
set CMDRUBYROOT=C:\Ruby22-x64
REM @todo would be better if this used same approach as bash
if exist "%CMDRUBYROOT%" set PATH=%HOME%\.gem\ruby\2.2.0\bin;%PATH%

REM Node.js
set CMDNODEJSROOT=C:\nodejs
if exist "%CMDNODEJSROOT%" set PATH=%HOME%\.node_modules;%PATH

REM Go
set CMDGOROOT=C:\Go
if exist "%CMDGOROOT%" set PATH=%CMDOPTLOCAL%\src\go\bin;%PATH%

REM Emacs
set CMDEMACSROOT=C:\emacs-24.5-bin-i686-mingw32
if exist "%CMDEMACSROOT%" set PATH=%CMDEMACSROOT%\bin;%PATH%
if exist "%CMDEMACSROOT%" (
   set ALTERNATE_EDITOR=
   set EDITOR=emacsclient -a notepad.exe
)

REM local .cmdrc
if exist "%HOME%"\.cmdrc.local.bat (
   call "%HOME%"\.cmdrc.local.bat
)
