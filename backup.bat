@echo off
REM Definir la unidad para el backup (D: si existe, de lo contrario C:)
set DRIVE=C:
if exist D:\ set DRIVE=D:

set BACKUP_DIR=%DRIVE%\Backups

REM Crear la carpeta si no existe
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM Otorgar permisos de escritura a todos en la carpeta para evitar que SQL Server de error de escritura
icacls "%BACKUP_DIR%" /grant Todos:(OI)(CI)F /T >nul 2>&1
icacls "%BACKUP_DIR%" /grant Everyone:(OI)(CI)F /T >nul 2>&1

REM Obtener timestamp seguro
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Get-Date -Format 'yyyyMMdd_HHmmss'"') do set TS=%%i

set FILE=bd_clinica_%TS%.bak

echo Iniciando backup de bd_clinica...
echo Destino: %BACKUP_DIR%\%FILE%
echo.

sqlcmd -S localhost\SQLEXPRESS -U sa -P Clinica2026* -C -Q "BACKUP DATABASE [bd_clinica] TO DISK = '%BACKUP_DIR%\%FILE%' WITH FORMAT, INIT;"

if %ERRORLEVEL% equ 0 (
    echo.
    echo Backup completado con exito: %BACKUP_DIR%\%FILE%
) else (
    echo.
    echo Error al realizar el backup.
    exit /b 1
)
