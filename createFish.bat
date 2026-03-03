@echo off
chcp 65001 >nul

:: Создание основной структуры папок
md 1_HARD\1_prj
md 1_HARD\2_sch
md 1_HARD\3_pcb
md 1_HARD\4_PKI
md 1_HARD\5_Fabrication

md 2_SOFT
md 3_DOC

:: Создание .gitignore для папки 1_HARD (Altium Designer)
cd 1_HARD
(
echo *.*
echo !*.PrjPCB
echo !*.SchDoc
echo !*.PcbDoc
echo !*.OutJob
echo **/History/
) > .gitignore
cd ..

:: Создание .gitignore для папки 2_SOFT
cd 2_SOFT
(
:: Игнорировать всё, кроме:
echo *.*
:: Но не игнорировать папку user и её содержимое
echo !user/
echo !user/**
:: Не игнорировать файлы проектов
echo !*.c
echo !*.cpp
echo !*.h
echo !*.hpp
echo !*.ioc
echo !*.uvprojx
echo !*.uvoptx
echo !*.ewp
echo !*.eww
:: Не игнорировать файлы настроек
echo !*.settings/
echo !*.vscode/
echo !*.idea/
echo !*.project
echo !*.cproject
echo !*.mxproject
:: Игнорировать временные и скомпилированные файлы
echo Debug/
echo Release/
echo build/
echo *.o
echo *.d
echo *.elf
echo *.hex
echo *.bin
echo *.map
echo *.su
echo *.tmp
) > .gitignore
cd ..

:: Создание .gitignore для папки 3_DOC
cd 3_DOC
(
:: Игнорировать всё, кроме текстовых и офисных документов
echo *.*
echo !*.txt
echo !*.md
echo !*.doc
echo !*.docx
echo !*.xls
echo !*.xlsx
echo !*.pdf
echo !*.odt
echo !*.rtf
) > .gitignore
cd ..

:: Создание корневого README.md с инструкциями по развертыванию
(
echo # Название проекта
echo.
echo ## Описание
echo Краткое описание проекта
echo.
echo ## Структура проекта
echo.
echo - **1_HARD/** - аппаратная часть (Altium Designer)
echo   - 1_prj/ - файлы проекта Altium
echo   - 2_sch/ - схемы
echo   - 3_pcb/ - печатные платы
echo   - 4_PKI/ - библиотеки компонентов
echo   - 5_Fabrication/ - файлы для производства
echo - **2_SOFT/** - программное обеспечение
echo   - user/ - пользовательский код
echo - **3_DOC/** - документация
echo.
echo ## Развертывание проекта
echo.
echo ### Необходимое ПО:
echo - Altium Designer (для аппаратной части)
echo - STM32CubeIDE / Keil / IAR (в зависимости от проекта)
echo.
echo ### Первоначальная настройка:
echo.
echo 1. Клонировать репозиторий:
echo    ```
echo    git clone [url-репозитория]
echo    cd [папка-проекта]
echo    ```
echo.
echo 2. Для работы с аппаратной частью:
echo    - Открыть файлы .PrjPCB из папки 1_HARD/1_prj/
echo.
echo 3. Для работы с программной частью:
echo    - Скопировать содержимое папки 2_SOFT/user/ в рабочую область вашей IDE
echo    - Импортировать проект из папки 2_SOFT/
echo.
echo 4. Документация доступна в папке 3_DOC/
echo.
echo ## Версионирование
echo.
echo Проект использует Git. Основные правила:
echo - В папке 1_HARD игнорируются все файлы, кроме проектных Altium
echo - В папке 2_SOFT сохраняется только папка user и файлы конфигурации
echo - Временные файлы сборки и Debug/Release папки исключены из репозитория
echo.
echo ## Автор
echo Ваше имя
) > README.md

:: Создание файла setup_project.bat для быстрого развертывания
(
echo @echo off
echo chcp 1251 ^>nul
echo.
echo echo Установка структуры проекта...
echo.
echo :: Проверка наличия Git
echo where git ^>nul 2^>^&1
echo if %%errorlevel%% neq 0 ^(
echo     echo Git не установлен! Пожалуйста, установите Git с https://git-scm.com/
echo     pause
echo     exit /b 1
echo ^)
echo.
echo :: Создание папок если их нет
echo if not exist "1_HARD" mkdir 1_HARD\1_prj 1_HARD\2_sch 1_HARD\3_pcb 1_HARD\4_PKI 1_HARD\5_Fabrication
echo if not exist "2_SOFT" mkdir 2_SOFT
echo if not exist "3_DOC" mkdir 3_DOC
echo if not exist "2_SOFT\user" mkdir 2_SOFT\user
echo.
echo echo Структура проекта готова!
echo echo.
echo echo Для начала работы:
echo echo 1. Откройте папку 1_HARD/1_prj/ для работы с аппаратурой
echo echo 2. Поместите код микроконтроллера в папку 2_SOFT/user/
echo echo 3. Документация находится в папке 3_DOC/
echo echo.
echo pause
) > setup_project.bat

:: Создание пустого файла .gitkeep в папке user для сохранения структуры
echo. > 2_SOFT\user\.gitkeep

:: Инициализация Git репозитория, если его нет
if not exist ".git" (
    git init
    echo.
    echo Git репозиторий инициализирован.
)

:: Создание корневого .gitignore для системных файлов
(
echo # Системные файлы
echo Thumbs.db
echo desktop.ini
echo .DS_Store
echo *.swp
echo *.swo
echo *~
echo.
echo # Файлы IDE
echo .vs/
echo .vscode/
echo *.user
echo *.workspace
) > .gitignore

echo.
echo Структура проекта успешно создана!
echo.
echo Для добавления в Git выполните:
echo   git add .
echo   git commit -m "Initial commit: project structure"
echo.
pause