@echo off
powershell -ExecutionPolicy Bypass -File "%~dp0Find-Suspects.ps1" -CommitSha %1
echo.
echo Script finished. Press any key to exit.
pause > nul
