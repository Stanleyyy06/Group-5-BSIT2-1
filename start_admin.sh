@echo off
REM =======================================================================
REM  NETAD Administrator Quick Start - Windows
REM =======================================================================

setlocal enabledelayedexpansion

echo.
echo =======================================================================
echo  NETAD Finals - System Administrator Setup
echo =======================================================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not in PATH
    echo Please install Python 3.11+ from https://www.python.org/
    pause
    exit /b 1
)

echo [OK] Python is installed
echo.

REM Check if .env exists
if not exist ".env" (
    echo [WARNING] .env file not found
    echo Creating .env from .env.example...
    if exist ".env.example" (
        copy ".env.example" ".env"
        echo [OK] .env created from template
    ) else (
        echo [ERROR] .env.example not found
        pause
        exit /b 1
    )
)

echo.
echo =======================================================================
echo  Step 1: Installing Dependencies
echo =======================================================================
echo.

pip install -q -r requirements.txt
if errorlevel 1 (
    echo [ERROR] Failed to install dependencies
    pause
    exit /b 1
)

echo [OK] Dependencies installed
echo.

echo =======================================================================
echo  Step 2: Setting Up Administrator Account
echo =======================================================================
echo.

python admin_setup.py
if errorlevel 1 (
    echo [ERROR] Admin setup failed
    echo.
    echo Trying emergency reset...
    python admin_reset.py
    if errorlevel 1 (
        echo [ERROR] Admin reset also failed
        pause
        exit /b 1
    )
)

echo.
echo =======================================================================
echo  Step 3: Starting Application
echo =======================================================================
echo.

python app.py

pause
