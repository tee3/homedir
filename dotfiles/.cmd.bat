@echo off
rem
rem A tool to customize a cmd.exe shell

rem Set HOME if it is not set.
if "%HOME%" == "" set HOME=%USERPROFILE%
if not exist "%HOME%" echo error: HOME, "%HOME%", does not exist && exit /b 1

cd "%HOME%"

rem Run a new shell with HOME set and a chance to set up the
rem environment.
"%HOME%"\.cmdrc.bat
