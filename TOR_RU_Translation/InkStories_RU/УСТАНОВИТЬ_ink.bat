@echo off
setlocal enabledelayedexpansion
title TOR_RU ink installer

set "LOG=%~dp0install_log.txt"
echo === run at %DATE% %TIME% === > "!LOG!"

echo.
echo =========================================================
echo   TOR Russian ink installer
echo =========================================================
echo.

set "SRC=%~dp0InkStories"
echo Source: !SRC!
>>"!LOG!" echo Source: !SRC!

if not exist "!SRC!" (
    echo ERROR: source folder not found next to this bat.
    echo Expected: !SRC!
    >>"!LOG!" echo [ERROR] Source folder missing
    exit /b 1
)

set "TARGET="

echo.
echo Searching for TOR_Core InkStories folder...
call :try "C:\Program Files (x86)\Steam\steamapps\workshop\content\261550\3025574678\InkStories"
if defined TARGET goto :found
call :try "D:\SteamLibrary\steamapps\workshop\content\261550\3025574678\InkStories"
if defined TARGET goto :found
call :try "E:\SteamLibrary\steamapps\workshop\content\261550\3025574678\InkStories"
if defined TARGET goto :found
call :try "F:\SteamLibrary\steamapps\workshop\content\261550\3025574678\InkStories"
if defined TARGET goto :found
call :try "C:\Program Files (x86)\Steam\steamapps\common\Mount & Blade II Bannerlord\Modules\TOR_Core\InkStories"
if defined TARGET goto :found
call :try "D:\SteamLibrary\steamapps\common\Mount & Blade II Bannerlord\Modules\TOR_Core\InkStories"
if defined TARGET goto :found
call :try "E:\SteamLibrary\steamapps\common\Mount & Blade II Bannerlord\Modules\TOR_Core\InkStories"
if defined TARGET goto :found

echo [X] TOR_Core InkStories folder not found.
echo     Check log: !LOG!
>>"!LOG!" echo [ERROR] TOR_Core InkStories folder not found in any known location
exit /b 1

:found
echo.
echo Found TOR_Core:
echo   !TARGET!
>>"!LOG!" echo Found TOR_Core: !TARGET!

set "BACKUP=!TARGET!_backup_EN"
if not exist "!BACKUP!" (
    echo Backing up English originals to:
    echo   !BACKUP!
    mkdir "!BACKUP!" 2>nul
    xcopy /y /e /i /q "!TARGET!\*.ink" "!BACKUP!\" >nul
    >>"!LOG!" echo [OK] Backup created
) else (
    echo Backup already exists:
    echo   !BACKUP!
    >>"!LOG!" echo [SKIP] Backup exists
)
echo.

echo Copying Russian ink files...
copy /y "!SRC!\*.ink" "!TARGET!\" >nul 2>>"!LOG!"
if errorlevel 1 (
    >>"!LOG!" echo [ERROR] copy failed errorlevel %ERRORLEVEL%
    echo [X] COPY FAILED. Try running as Administrator.
    echo     Check log: !LOG!
    exit /b 1
)
>>"!LOG!" echo [OK] Copy completed

echo.
echo =========================================================
echo   DONE. Restart Bannerlord.
echo =========================================================
echo Log: !LOG!
exit /b 0

:try
set "P=%~1"
if not exist "!P!" goto :try_miss
set "TARGET=!P!"
>>"!LOG!" echo [TRY OK] !P!
goto :eof
:try_miss
>>"!LOG!" echo [TRY NO] !P!
goto :eof
