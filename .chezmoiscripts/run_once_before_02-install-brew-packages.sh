#!/usr/bin/env bash
set -euo pipefail

if command -v brew >/dev/null 2>&1; then
    echo "Updating Homebrew..."
    brew update

    echo "Installing Homebrew Bundle..."
    brew tap homebrew/bundle

    echo "Installing packages from Brewfile..."
    brew bundle --file="{{ .chezmoi.sourceDir }}/brewfile"
else
    echo "Homebrew not found, skipping package installation."
    exit 1
fi
