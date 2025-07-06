@echo off
setlocal enabledelayedexpansion
:: Setup the name and version of the mod
FOR /F "tokens=*" %%F IN ('powershell "select-string -Path .\source\info.json -Pattern name.* | %% { $_.Matches } | %% { $_.Value } | select-string -Pattern :.* | %% { $_.Matches } | %% { $_.Value } | select-string -Pattern [a-zA-z-_0-9]+ | %% { $_.Matches } | %% { $_.Value }"') DO (
    SET "TITLE=%%F"
)
FOR /F "tokens=*" %%F IN ('powershell "select-string -Path .\source\info.json -Pattern version.*[0-9]+.[0-9]+.[0-9]+ | %% { $_.Matches } | %% { $_.Value } | select-string -Pattern '[0-9]+.[0-9]+.[0-9]+' | %% { $_.Matches } | %% { $_.Value }"') DO (
    SET "VERSION=%%F"
)
SET FULL_NAME=%TITLE%_%VERSION%
:: Make a temporary directory with the version and name, copy the relevant files to it
:: Zip it and move to Factorio install, and then get rid of the temp directory
mkdir build
mkdir build\%FULL_NAME%

xcopy /E source build\%FULL_NAME%
:: wait a moment to let everything get copied
TIMEOUT /T 1 /NOBREAK

powershell Compress-Archive build\%FULL_NAME% build\%FULL_NAME%.zip
:: wait a moment to make sure powershell is done
TIMEOUT /T 1 /NOBREAK
move /Y build\%FULL_NAME%.zip %APPDATA%\Factorio\mods
rmdir /S /Q build

echo Built %FULL_NAME% into %APPDATA%\Factorio\mods at %TIME%

endlocal
