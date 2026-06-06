@echo off
echo.
echo  ExpenseIL Setup
echo  ================
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup.ps1"
if errorlevel 1 (
    echo.
    echo  Setup failed. Try running as Administrator.
)
echo.
pause
