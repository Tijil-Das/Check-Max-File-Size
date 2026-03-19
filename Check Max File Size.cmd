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
    set /a MAX_SIZE_MB=%MAX_SIZE% / 1048576
    echo.
    echo  Largest File : %MAX_FILE%
    echo  Size         : %MAX_SIZE% bytes  (!MAX_SIZE_MB! MB^)
)

echo.
pause
