#!/usr/bin/env bash

# Forge GTM Environment Setup (Mac)
# Run with: bash setup-mac.sh

set -euo pipefail

echo ""
echo "Forge GTM Environment Setup"
echo "This script installs everything you need to use Forge GTM."
echo "It will take a few minutes. Do not close this window until you see \"Setup complete\"."
echo ""

FAILURES=()

# ─── Homebrew ───────────────────────────────────────────────────────────────

echo "[CHECKING] Homebrew..."

if command -v brew &>/dev/null; then
  echo "[OK] Homebrew is installed"
else
  echo "[INSTALLING] Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    FAILURES+=("Homebrew")
    echo "[ERROR] Homebrew could not be installed"
  }

  # Add Homebrew to PATH for Apple Silicon Macs
  if [[ -f /opt/homebrew/bin/brew ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "[OK] Homebrew is installed"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
    echo "[OK] Homebrew is installed"
  fi
fi

# ─── Node.js ────────────────────────────────────────────────────────────────

echo "[CHECKING] Node.js..."

if command -v node &>/dev/null; then
  NODE_VERSION=$(node --version)
  echo "[OK] Node.js is installed (version $NODE_VERSION)"
else
  echo "[INSTALLING] Installing Node.js..."
  if command -v brew &>/dev/null; then
    brew install node 2>&1 || {
      FAILURES+=("Node.js")
      echo "[ERROR] Node.js could not be installed"
    }
    if command -v node &>/dev/null; then
      NODE_VERSION=$(node --version)
      echo "[OK] Node.js is installed (version $NODE_VERSION)"
    else
      FAILURES+=("Node.js")
      echo "[ERROR] Node.js was not found after installation"
    fi
  else
    FAILURES+=("Node.js")
    echo "[ERROR] Homebrew is not available. Node.js cannot be installed automatically."
  fi
fi

# ─── Git ────────────────────────────────────────────────────────────────────

echo "[CHECKING] Git..."

if command -v git &>/dev/null; then
  echo "[OK] Git is installed"
else
  echo "[INSTALLING] Installing Git (this may open an installation window, follow the prompts)..."
  xcode-select --install 2>&1 || true
  # Wait for installation to complete
  until command -v git &>/dev/null; do
    sleep 5
  done
  if command -v git &>/dev/null; then
    echo "[OK] Git is installed"
  else
    FAILURES+=("Git")
    echo "[ERROR] Git could not be installed"
  fi
fi

# ─── Ghostscript ────────────────────────────────────────────────────────────

echo "[CHECKING] Ghostscript..."

if command -v gs &>/dev/null; then
  echo "[OK] Ghostscript is installed"
else
  echo "[INSTALLING] Installing Ghostscript..."
  if command -v brew &>/dev/null; then
    brew install ghostscript 2>&1 || {
      FAILURES+=("Ghostscript")
      echo "[ERROR] Ghostscript could not be installed"
    }
    if command -v gs &>/dev/null; then
      echo "[OK] Ghostscript is installed"
    else
      FAILURES+=("Ghostscript")
      echo "[ERROR] Ghostscript was not found after installation"
    fi
  else
    FAILURES+=("Ghostscript")
    echo "[ERROR] Homebrew is not available. Ghostscript cannot be installed automatically."
  fi
fi

# ─── Final verification ──────────────────────────────────────────────────────

echo ""
echo "Checking everything is in place..."

[[ ! " ${FAILURES[*]} " =~ "Homebrew" ]] && ! command -v brew &>/dev/null && FAILURES+=("Homebrew")
[[ ! " ${FAILURES[*]} " =~ "Node.js" ]] && ! command -v node &>/dev/null && FAILURES+=("Node.js")
[[ ! " ${FAILURES[*]} " =~ "Git" ]] && ! command -v git &>/dev/null && FAILURES+=("Git")
[[ ! " ${FAILURES[*]} " =~ "Ghostscript" ]] && ! command -v gs &>/dev/null && FAILURES+=("Ghostscript")

if [[ ${#FAILURES[@]} -eq 0 ]]; then
  echo ""
  echo "Setup complete. You are ready to use Forge GTM."
  echo ""
else
  echo ""
  echo "[ERROR] Setup did not complete successfully."
  echo "[ERROR] The following could not be installed: ${FAILURES[*]}"
  echo "Please contact your Forge GTM account holder before trying again."
  echo ""
  exit 1
fi
