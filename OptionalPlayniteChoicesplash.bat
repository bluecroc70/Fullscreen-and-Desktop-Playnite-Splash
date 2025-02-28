@echo off
powershell -ExecutionPolicy Bypass -File "%~dp0popup.ps1"

:: Read the user choice from a temp file
for /f %%A in ('type "%temp%\choice.txt"') do set choice=%%A
del "%temp%\choice.txt"

if "%choice%"=="1" (
    start "" "C:\ffmpeg\playnite splash.bat"
) else if "%choice%"=="2" (
    start "" "C:\Users\Fama\AppData\Local\Playnite\Playnite.DesktopApp.exe"
) else (
    echo Invalid choice. Exiting.
)
exit
