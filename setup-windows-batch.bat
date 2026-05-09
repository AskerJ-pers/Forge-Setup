@echo off
setlocal enabledelayedexpansion

echo.
echo Forge GTM -- Environment Setup
echo This script installs everything you need to use Forge GTM.
echo It will take a few minutes. Do not close this window until you see "Setup complete".
echo.

:: ─── winget ──────────────────────────────────────────────────────────────────

echo [CHECKING] Package manager (winget)...

where winget >nul 2>&1
if errorlevel 1 (
    echo.
    echo [ERROR] winget is not available on your system.
    echo winget is included with Windows 10 version 1809 or later, and Windows 11.
    echo Please contact your Forge GTM account holder for help with your setup.
    echo.
    pause
    exit /b 1
)

echo [OK] Package manager is available

:: ─── Node.js ─────────────────────────────────────────────────────────────────

echo [CHECKING] Node.js...

where node >nul 2>&1
if errorlevel 1 (
    echo [INSTALLING] Installing Node.js...
    winget install OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements
    if errorlevel 1 (
        echo [ERROR] Node.js could not be installed.
        echo Please contact your Forge GTM account holder before trying again.
        pause
        exit /b 1
    )
    echo [OK] Node.js is installed
) else (
    echo [OK] Node.js is installed
)

:: ─── Git ─────────────────────────────────────────────────────────────────────

echo [CHECKING] Git...

where git >nul 2>&1
if errorlevel 1 (
    echo [INSTALLING] Installing Git...
    winget install Git.Git --silent --accept-source-agreements --accept-package-agreements
    if errorlevel 1 (
        echo [ERROR] Git could not be installed.
        echo Please contact your Forge GTM account holder before trying again.
        pause
        exit /b 1
    )
    echo [OK] Git is installed
) else (
    echo [OK] Git is installed
)

:: ─── Ghostscript ─────────────────────────────────────────────────────────────

echo [CHECKING] Ghostscript...

where gswin64c >nul 2>&1
if errorlevel 1 (
    echo [INSTALLING] Installing Ghostscript...
    winget install ArtifexSoftware.GhostScript --silent --accept-source-agreements --accept-package-agreements
    if errorlevel 1 (
        echo [ERROR] Ghostscript could not be installed.
        echo Please contact your Forge GTM account holder before trying again.
        pause
        exit /b 1
    )
    echo [OK] Ghostscript is installed
) else (
    echo [OK] Ghostscript is installed
)

:: ─── Done ────────────────────────────────────────────────────────────────────

echo.
echo Setup complete. You are ready to use Forge GTM.
echo Please close this window and reopen your terminal before using Claude Code.
echo Press any key to close.
pause >nul
