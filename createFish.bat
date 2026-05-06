@echo off
chcp 1251 >nul

:: Создание папок
mkdir 1_HARD\1_prj 2>nul
mkdir 1_HARD\2_sch 2>nul
mkdir 1_HARD\3_pcb 2>nul
mkdir 1_HARD\4_PKI 2>nul
mkdir 1_HARD\5_Fabrication 2>nul
mkdir 2_SOFT\user 2>nul
mkdir 3_DOC 2>nul

:: Создание .gitignore для 1_HARD
echo *.* > 1_HARD\.gitignore
echo !*.PrjPCB >> 1_HARD\.gitignore
echo !*.SchDoc >> 1_HARD\.gitignore
echo !*.PcbDoc >> 1_HARD\.gitignore
echo !*.OutJob >> 1_HARD\.gitignore
echo **/History/ >> 1_HARD\.gitignore

:: Создание .gitignore для 2_SOFT
echo *.* > 2_SOFT\.gitignore
echo !user/ >> 2_SOFT\.gitignore
echo !user/** >> 2_SOFT\.gitignore
echo !*.c >> 2_SOFT\.gitignore
echo !*.cpp >> 2_SOFT\.gitignore
echo !*.h >> 2_SOFT\.gitignore
echo Debug/ >> 2_SOFT\.gitignore
echo Release/ >> 2_SOFT\.gitignore

:: Создание .gitignore для 3_DOC
echo *.* > 3_DOC\.gitignore
echo !*.txt >> 3_DOC\.gitignore
echo !*.md >> 3_DOC\.gitignore
echo !*.pdf >> 3_DOC\.gitignore

:: Создание README.md
echo # Test Project > README.md
echo. >> README.md
echo Project structure created >> README.md

:: Создание .gitkeep
echo. > 2_SOFT\user\.gitkeep

echo Done!
pause