@echo off
setlocal enabledelayedexpansion

:: -----------------------------------------------
:: max_file_size.cmd
:: Finds the largest file in a given directory
:: -----------------------------------------------

set /p "TARGET_DIR=Enter directory path: "

if not exist "%TARGET_DIR%" (
    echo ERROR: Directory not found.
    pause
    exit /b 1
)

set MAX_SIZE=0
set MAX_FILE=

for /r "%TARGET_DIR%" %%F in (*) do (
    set "FSIZE=%%~zF"
    if !FSIZE! gtr !MAX_SIZE! (
        set MAX_SIZE=!FSIZE!
        set MAX_FILE=%%F
    )
)

if "%MAX_FILE%"=="" (
    echo No files found in "%TARGET_DIR%".
) else (
    echo.
    echo  Largest File : %MAX_FILE%
    echo  Size         : %MAX_SIZE% bytes
)

echo.
pause
