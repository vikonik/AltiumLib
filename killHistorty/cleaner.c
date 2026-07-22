#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <direct.h>

#define MAX_PATH_LEN 260

void DeleteDirectory(const char *path) {
    char search_path[MAX_PATH_LEN];
    WIN32_FIND_DATA find_data;
    HANDLE find_handle;

    snprintf(search_path, sizeof(search_path), "%s\\*", path);

    find_handle = FindFirstFile(search_path, &find_data);
    if (find_handle == INVALID_HANDLE_VALUE) return;

    do {
        if (strcmp(find_data.cFileName, ".") == 0 || strcmp(find_data.cFileName, "..") == 0) {
            continue;
        }

        char full_path[MAX_PATH_LEN];
        snprintf(full_path, sizeof(full_path), "%s\\%s", path, find_data.cFileName);

        if (find_data.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
            DeleteDirectory(full_path);
        } else {
            DeleteFile(full_path);
        }
    } while (FindNextFile(find_handle, &find_data));

    FindClose(find_handle);
    RemoveDirectory(path);
}

void WalkDirectory(const char *base_path) {
    char search_path[MAX_PATH_LEN];
    WIN32_FIND_DATA find_data;
    HANDLE find_handle;

    snprintf(search_path, sizeof(search_path), "%s\\*", base_path);

    find_handle = FindFirstFile(search_path, &find_data);
    if (find_handle == INVALID_HANDLE_VALUE) return;

    do {
        if (strcmp(find_data.cFileName, ".") == 0 || strcmp(find_data.cFileName, "..") == 0) {
            continue;
        }

        if (find_data.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
            char full_path[MAX_PATH_LEN];
            snprintf(full_path, sizeof(full_path), "%s\\%s", base_path, find_data.cFileName);

            if (_stricmp(find_data.cFileName, "History") == 0) {
                printf("[НАЙДЕНО] %s\n", full_path);
                printf("[УДАЛЕНИЕ] ... ");
                DeleteDirectory(full_path);
                printf("ГОТОВО\n");
            } else {
                WalkDirectory(full_path);
            }
        }
    } while (FindNextFile(find_handle, &find_data));

    FindClose(find_handle);
}

int main(int argc, char *argv[]) {
    // Переключаем консоль в UTF-8
    SetConsoleOutputCP(CP_UTF8);
    
    char start_dir[MAX_PATH_LEN];
    char current_dir[MAX_PATH_LEN];

    _getcwd(current_dir, sizeof(current_dir));

    if (argc > 1) {
        strncpy(start_dir, argv[1], MAX_PATH_LEN - 1);
        start_dir[MAX_PATH_LEN - 1] = '\0';

        if (start_dir[0] == '"') {
            memmove(start_dir, start_dir + 1, strlen(start_dir));
            size_t len = strlen(start_dir);
            if (len > 0 && start_dir[len - 1] == '"') {
                start_dir[len - 1] = '\0';
            }
        }

        printf("=========================================\n");
        printf("  Очистка History (Altium Designer)\n");
        printf("=========================================\n\n");
        printf("Целевая папка: %s\n", start_dir);
        printf("Текущая папка: %s\n\n", current_dir);
        
        DWORD attrs = GetFileAttributes(start_dir);
        if (attrs == INVALID_FILE_ATTRIBUTES) {
            printf("ОШИБКА: Папка не найдена!\n");
            system("pause");
            return 1;
        }

        if (!(attrs & FILE_ATTRIBUTE_DIRECTORY)) {
            printf("ОШИБКА: Это файл, а не папка!\n");
            system("pause");
            return 1;
        }

        printf("Поиск папок 'History'...\n\n");
        WalkDirectory(start_dir);

    } else {
        printf("=========================================\n");
        printf("  Очистка History (Altium Designer)\n");
        printf("=========================================\n\n");
        printf("Папка не указана.\n");
        printf("Поиск в ТЕКУЩЕЙ папке:\n");
        printf("%s\n\n", current_dir);
        printf("Совет: Перетащите нужную папку на EXE-файл,\n");
        printf("чтобы очистить только её.\n\n");
        printf("Начинаем поиск...\n\n");

        WalkDirectory(current_dir);
    }

    printf("\n=========================================\n");
    printf("ГОТОВО!\n");
    printf("=========================================\n");
    system("pause");
    return 0;
}