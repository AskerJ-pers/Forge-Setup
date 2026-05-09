# Forge GTM Environment Setup (Windows, PowerShell)
# Run with: .\setup-windows-powershell.ps1

Write-Host ""
Write-Host "Forge GTM Environment Setup"
Write-Host "This script installs everything you need to use Forge GTM."
Write-Host "It will take a few minutes. Do not close this window until you see ""Setup complete""."
Write-Host ""

$failures = @()

# ─── winget ──────────────────────────────────────────────────────────────────

Write-Host "[CHECKING] Package manager (winget)..."

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "[ERROR] winget is not available on your system."
    Write-Host "winget is included with Windows 10 (version 1809 or later) and Windows 11."
    Write-Host "If your system does not have it, please use the alternative setup file: setup-windows-batch.bat"
    Write-Host "Contact your Forge GTM account holder if you are unsure what to do."
    Write-Host ""
    exit 1
}

Write-Host "[OK] Package manager is available"

# Refresh PATH helper
function Refresh-Path {
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" +
                [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# ─── Node.js ─────────────────────────────────────────────────────────────────

Write-Host "[CHECKING] Node.js..."

if (Get-Command node -ErrorAction SilentlyContinue) {
    $nodeVersion = node --version
    Write-Host "[OK] Node.js is installed (version $nodeVersion)"
} else {
    Write-Host "[INSTALLING] Installing Node.js..."
    try {
        winget install OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements
        Refresh-Path
        if (Get-Command node -ErrorAction SilentlyContinue) {
            $nodeVersion = node --version
            Write-Host "[OK] Node.js is installed (version $nodeVersion)"
        } else {
            $failures += "Node.js"
            Write-Host "[ERROR] Node.js was not found after installation"
        }
    } catch {
        $failures += "Node.js"
        Write-Host "[ERROR] Node.js could not be installed"
    }
}

# ─── Git ─────────────────────────────────────────────────────────────────────

Write-Host "[CHECKING] Git..."

if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Host "[OK] Git is installed"
} else {
    Write-Host "[INSTALLING] Installing Git..."
    try {
        winget install Git.Git --silent --accept-source-agreements --accept-package-agreements
        Refresh-Path
        if (Get-Command git -ErrorAction SilentlyContinue) {
            Write-Host "[OK] Git is installed"
        } else {
            $failures += "Git"
            Write-Host "[ERROR] Git was not found after installation"
        }
    } catch {
        $failures += "Git"
        Write-Host "[ERROR] Git could not be installed"
    }
}

# ─── Ghostscript ─────────────────────────────────────────────────────────────

Write-Host "[CHECKING] Ghostscript..."

if (Get-Command gswin64c -ErrorAction SilentlyContinue) {
    Write-Host "[OK] Ghostscript is installed"
} else {
    Write-Host "[INSTALLING] Installing Ghostscript..."
    try {
        winget install ArtifexSoftware.GhostScript --silent --accept-source-agreements --accept-package-agreements
        Refresh-Path
        if (Get-Command gswin64c -ErrorAction SilentlyContinue) {
            Write-Host "[OK] Ghostscript is installed"
        } else {
            $failures += "Ghostscript"
            Write-Host "[ERROR] Ghostscript was not found after installation"
        }
    } catch {
        $failures += "Ghostscript"
        Write-Host "[ERROR] Ghostscript could not be installed"
    }
}

# ─── Final verification ───────────────────────────────────────────────────────

Write-Host ""
Write-Host "Checking everything is in place..."

Refresh-Path

if (-not (Get-Command node -ErrorAction SilentlyContinue) -and $failures -notcontains "Node.js") {
    $failures += "Node.js"
}
if (-not (Get-Command git -ErrorAction SilentlyContinue) -and $failures -notcontains "Git") {
    $failures += "Git"
}
if (-not (Get-Command gswin64c -ErrorAction SilentlyContinue) -and $failures -notcontains "Ghostscript") {
    $failures += "Ghostscript"
}

if ($failures.Count -eq 0) {
    Write-Host ""
    Write-Host "Setup complete. You are ready to use Forge GTM."
    Write-Host "Note: if any command is not found when you first use Claude Code, close and reopen your terminal window to reload your PATH."
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "[ERROR] Setup did not complete successfully."
    Write-Host "[ERROR] The following could not be installed: $($failures -join ', ')"
    Write-Host "Please contact your Forge GTM account holder before trying again."
    Write-Host ""
    exit 1
}
