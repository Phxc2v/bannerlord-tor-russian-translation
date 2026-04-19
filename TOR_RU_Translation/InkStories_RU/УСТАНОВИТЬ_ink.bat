@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title Установка русских ink-квестов для The Old Realms

echo.
echo ===========================================================
echo   Установка русских ink-квестов для The Old Realms
echo ===========================================================
echo.

set "SRC=%~dp0"
set "TARGET="

rem Автопоиск Steam Workshop TOR_Core (id 3025574678)
for %%D in (
    "C:\Program Files (x86)\Steam\steamapps\workshop\content\261550\3025574678\InkStories"
    "D:\SteamLibrary\steamapps\workshop\content\261550\3025574678\InkStories"
    "E:\SteamLibrary\steamapps\workshop\content\261550\3025574678\InkStories"
    "F:\SteamLibrary\steamapps\workshop\content\261550\3025574678\InkStories"
) do (
    if exist "%%~D" (
        set "TARGET=%%~D"
        goto :found
    )
)

rem Fallback: standalone TOR_Core installation
for %%D in (
    "C:\Program Files (x86)\Steam\steamapps\common\Mount ^& Blade II Bannerlord\Modules\TOR_Core\InkStories"
    "D:\SteamLibrary\steamapps\common\Mount ^& Blade II Bannerlord\Modules\TOR_Core\InkStories"
    "E:\SteamLibrary\steamapps\common\Mount ^& Blade II Bannerlord\Modules\TOR_Core\InkStories"
) do (
    if exist "%%~D" (
        set "TARGET=%%~D"
        goto :found
    )
)

echo [!] Не найдена папка TOR_Core\InkStories автоматически.
echo.
echo Введи путь вручную (например:
echo   C:\Program Files (x86)\Steam\steamapps\workshop\content\261550\3025574678\InkStories
echo  ):
set /p TARGET=Путь:
if not exist "!TARGET!" (
    echo [X] Указанный путь не существует. Прерываю.
    pause
    exit /b 1
)

:found
echo [+] TOR_Core найден: !TARGET!
echo.

rem Бэкап оригиналов
set "BACKUP=!TARGET!_backup_EN"
if not exist "!BACKUP!" (
    echo [+] Делаю бэкап оригинальных английских файлов -^> !BACKUP!
    mkdir "!BACKUP!" 2>nul
    xcopy /y /e /i "!TARGET!\*.ink" "!BACKUP!\" >nul
) else (
    echo [=] Бэкап уже существует, пропускаю: !BACKUP!
)
echo.

rem Копируем русские ink-файлы (из подпапки InkStories)
echo [+] Копирую русские ink-файлы из %SRC%InkStories\...
if not exist "%SRC%InkStories\*.ink" (
    echo [X] Не нашёл .ink файлов в %SRC%InkStories\ — поврежденная установка модуля?
    pause
    exit /b 1
)
copy /y "%SRC%InkStories\*.ink" "!TARGET!\" >nul
if errorlevel 1 (
    echo [X] Ошибка копирования. Запусти от имени администратора, если файлы в Program Files.
    pause
    exit /b 1
)

echo.
echo ===========================================================
echo [OK] Готово! Перезапусти Bannerlord.
echo ===========================================================
echo.
echo Если нужно откатить — скопируй всё из
echo   !BACKUP!
echo обратно в
echo   !TARGET!
echo.
pause
