@echo off
REM A tool to customize a cmd.exe shell

REM Set HOME if it is not set.
if "%HOME%" == "" set HOME=C:\Users\%USERNAME%

REM Run a new shell with HOME set and a chance to set up the
REM environment.
"%HOME%"\.cmdrc.bat
