@echo off
chcp 65001 >nul
cd /d "%~dp0"
python json_to_access.py
if errorlevel 1 pause
