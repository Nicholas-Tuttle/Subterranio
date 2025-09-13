@echo off
setlocal enabledelayedexpansion

echo ----- Building all mods at once

SET SUB_MODS=subterranio subterranio-base subterranio-nauvis

FOR %%X IN (%SUB_MODS%) DO (
    echo --- Building %%X
    cd .\%%X
    call .\make.bat
    cd ..
    echo --- Done building %%X
)

echo ----- Done building all mods

endlocal
