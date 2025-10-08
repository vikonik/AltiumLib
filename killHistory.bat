@echo off
chcp 1251 >nul
setlocal EnableDelayedExpansion

:: Подсчет количества папок History для удаления
set /a "count=0"
for /d %%i in (*) do (
    pushd %%i
    for /d %%j in (*) do (
        if exist %%j\History (
            set /a "count+=1"
        )
    )
    popd
)

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
