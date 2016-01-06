@echo off

REM local .cmdrc
if exist "%HOME%"\.cmdrc.local.bat (
   call "%HOME%"\.cmdrc.local.bat
)
