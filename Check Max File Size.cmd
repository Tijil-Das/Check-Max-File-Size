@echo off
setlocal enabledelayedexpansion

:: -----------------------------------------------
:: max_file_size.cmd
:: Finds the largest file in a given directory
:: Displays size in appropriate unit: B/KB/MB/GB/TB
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
    echo.
    pause
    exit /b 0
)

:: --- Determine unit ---
set SIZE=!MAX_SIZE!
set UNIT=B
set DIVISOR=1

if !SIZE! geq 1099511627776 (
    set UNIT=TB
    set DIVISOR=1099511627776
) else if !SIZE! geq 1073741824 (
    set UNIT=GB
    set DIVISOR=1073741824
) else if !SIZE! geq 1048576 (
    set UNIT=MB
    set DIVISOR=1048576
) else if !SIZE! geq 1024 (
    set UNIT=KB
    set DIVISOR=1024
)

:: --- Compute whole and decimal parts ---
if "!UNIT!"=="B" (
    set DISPLAY=!SIZE! B
) else (
    set /a WHOLE=!SIZE! / !DIVISOR!
    set /a DEC=(!SIZE! * 100 / !DIVISOR!) %% 100
    if !DEC! lss 10 set DEC=0!DEC!
    set DISPLAY=!WHOLE!.!DEC! !UNIT!
)

echo.
echo  Largest File : !MAX_FILE!
echo  Size         : !DISPLAY!
echo.
pause
