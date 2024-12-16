@echo off
setlocal enabledelayedexpansion
:: Setup the name and version of the mod
SET TITLE=subterranio
SET VERSION=0.0.1
SET FULL_NAME=%TITLE%_%VERSION%
:: Make a temporary directory with the version and name, copy the relevant files to it
:: Zip it and move to Factorio install, and then get rid of the temp directory
mkdir %FULL_NAME%

:: Copy all the relevant files. This could be improved syntax-wise...
copy info.json %FULL_NAME%
copy LICENSE %FULL_NAME%
copy make.bat %FULL_NAME%
copy README.md %FULL_NAME%

powershell Compress-Archive %FULL_NAME% %FULL_NAME%.zip
move /Y %FULL_NAME%.zip %APPDATA%\Factorio\mods
del /Q %FULL_NAME%
rmdir %FULL_NAME%

echo Successfully built %FULL_NAME% into %APPDATA%\Factorio\mods at %TIME%

endlocal