@echo off
rem
rem A tool to customize a cmd.exe shell

rem Set HOME if it is not set.
if "%HOME%" == "" set HOME=C:\Users\%USERNAME%

rem Run a new shell with HOME set and a chance to set up the
rem environment.
"%HOME%"\.cmdrc.bat
