@echo off
chcp 1251 >nul
setlocal EnableDelayedExpansion

:: Подсчет количества папок History для удаления
set /a "count=0"
set /a "total=0"

rem Функция для определения глубины вложенности папок
:FindDepth
set "currentFolder=%~1"
set "depth=0"
:Loop
if exist "%currentFolder%\*" (
    set "nextLevelFolder=%currentFolder%\*"
    set /a depth+=1
    set "currentFolder="
    for /d %%d in ("%nextLevelFolder%") do set "currentFolder=%%~fd"
    if defined currentFolder goto :Loop
)
exit /b %depth%

echo Start
rem Основной скрипт для определения глубины вложенных папок в каждой основной папке
for /d %%i in (*) do (
    call :FindDepth "%%i"
    echo Depth of folders in %%i: !depth!
)

echo Total folders scanned: %total%
echo Total subfolders found: %count%
:: Удаление папок History и отображение прогресса с задержкой
for /d %%i in (*) do (
    pushd %%i
    for /d %%j in (*) do (
        if exist %%j\History (
			echo Deleting: %%i\%%j\History
            rmdir /s /q %%j\History
        )
    )
    popd
)

echo Press any key to exit...
pause >nul
endlocal
