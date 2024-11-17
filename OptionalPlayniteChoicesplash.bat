@echo off
echo Choose an application to launch:
echo 1. Launch App Full
echo 2. Launch App Desk
set /p choice=Enter your choice (1=full 2=desk): 

if "%choice%"=="1" (
    start "" "C:\ffmpeg\playnite splash.bat"
) else if "%choice%"=="2" (
    start "" "C:\Users\Fama\AppData\Local\Playnite\Playnite.DesktopApp.exe"
) else (
    echo Invalid choice. Exiting.
)