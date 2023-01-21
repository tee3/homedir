@echo off
rem
rem Download and bootstrap the indicated version of the Boost C++
rem Libraries.

if "%~1" == "" echo usage: %0 "<version>" && exit /b 1

if "%HOME%" == "" set HOME=%USERPROFILE%
if not exist "%HOME%" echo error: HOME, "%HOME%", does not exist && exit /b 1

set version=%1
set version_name=%version:.=_%
set root="%HOME%"\opt\local\src\boost
set directory=boost_%version_name%
set filename=%directory%.zip

if not exist "%root%" echo error: %root% does not exist && exit /b 1
if exist "%root%"\"%directory%" echo error: "%root%"\"%directory%" already exists && exit /b 1
if exist "%root%"\"%filename%" echo error: "%root%"\"%filename%" already exists && exit /b 1

set url=https://boostorg.jfrog.io/artifactory/main/release/"%version%"/source/"%filename%"

curl --no-clobber --location --remote-name --output-dir "%root%" "%url%"

if not exist %root%\%filename% echo error: %root%\%filename% does not exist && exit /b 1

tar -x -z -f %root%\%filename% -C %root%

if not exist %root%\%directory% echo error: %root%\%directory% does not exist && exit /b 1

set cwd="%cd%"
cd %root%\%directory%

call bootstrap
cd "%cwd%"

rem @todo needs to be batchified
rem cat > "%root%"\b2_"%version_name%".bat <<EOF
rem if [ -n "\${BOOST_BUILD_PATH}" ]; then
rem     set BOOST_BUILD_PATH="\${BOOST_BUILD_PATH}":"%root%"\"%directory%"\tools\build
rem else
rem     set BOOST_BUILD_PATH="%root%"\"%directory%"\tools\build
rem fi
rem "%root%"\"%directory%"\b2 "\$@"
rem EOF
