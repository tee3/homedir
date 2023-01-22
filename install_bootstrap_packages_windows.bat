@echo off
rem
rem Install bootstrap packages for Windows.
rem
rem This assumes that the current user is the user used to install
rem packages and has the proper administrator privileges.

echo "Go to Settings->Update & Security->For developers->Developer Mode, enable it."
set /p id="Press Enter when complete ..."

echo "Install App Installer from the Microsoft Store."
set /p id="Press Enter when complete ..."

echo "Install the Windows Package Manager CLI (`winget`) from https://github.com/microsoft/winget-cli."
set /p id="Press Enter when complete ..."

winget install --silent --exact --id Microsoft.VisualStudio.2019.Community --accept-package-agreements --accept-source-agreements
if %ERRORLEVEL% NEQ 0 echo "error: failed to install Microsoft.VisualStudio.2019.Community."
winget install --silent --exact --id Python.Python.3 --accept-package-agreements --accept-source-agreements
if %ERRORLEVEL% NEQ 0 echo "error: failed to install Python.Python."
winget install --silent --exact --id Git.Git --accept-package-agreements --accept-source-agreements
if %ERRORLEVEL% NEQ 0 echo "error: failed to install Git.Git."
