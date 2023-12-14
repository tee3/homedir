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

winget install --silent --exact --id Microsoft.VisualStudio.2022.BuildTools --accept-package-agreements --accept-source-agreements
if %ERRORLEVEL% neq 0 echo "error: failed to install Microsoft.VisualStudio.2022.BuildTools."

echo "Run Visual Studio Installer and configure Microsoft Visual Studio Build Tools for C++ Desktop Development."
set /p id="Press Enter when complete ..."

winget install --silent --exact --id Python.Python.3.12 --accept-package-agreements --accept-source-agreements
if %ERRORLEVEL% neq 0 echo "error: failed to install Python.Python."

PowerShell.exe -Command "Add-WindowsCapability -Online -Name OpenSSH.Client"
PowerShell.exe -Command "Get-Service ssh-agent | Set-Service -StartupType Automatic"
PowerShell.exe -Command "Start-Service ssh-agent"

winget install --silent --exact --id Git.Git --accept-package-agreements --accept-source-agreements
if %ERRORLEVEL% NEQ 0 echo "error: failed to install Git.Git."
