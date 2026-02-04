#!/usr/bin/env bash
set -euo pipefail

if command -v brew >/dev/null 2>&1; then
    echo "Updating Homebrew..."
    brew update

    echo "Installing packages from Brewfile..."
    brew bundle --file="$HOME/.dotfiles/brewfile" --no-upgrade || true
else
    echo "Homebrew not found, skipping package installation."
    exit 1
fi
