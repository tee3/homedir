@echo off
REM A tool to customize a cmd.exe shell

REM Run a new shell with HOME set and a chance to set up the
REM environment.
set HOME=C:\Users\%USERNAME%
"%HOME%"\.cmdrc.bat
