#!/usr/bin/env bash
set -euo pipefail

if ! command -v fish >/dev/null 2>&1; then
    echo "Fish shell not found, skipping fish plugins installation."
    exit 0
fi

echo "Installing Fish plugins..."

# Install Fisher (fish plugin manager) if not already installed
if ! fish -c "type -q fisher" 2>/dev/null; then
    echo "Installing Fisher..."
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
else
    echo "Fisher already installed"
fi

# Install tide prompt theme
if ! fish -c "type -q tide" 2>/dev/null; then
    echo "Installing tide prompt theme..."
    fish -c "fisher install IlanCosman/tide@v6"
else
    echo "Tide already installed"
fi

# Install fzf.fish for better fzf integration
if ! fish -c "functions -q fzf_configure_bindings" 2>/dev/null; then
    echo "Installing fzf.fish..."
    fish -c "fisher install PatrickF1/fzf.fish"
else
    echo "fzf.fish already installed"
fi

echo "Fish plugins installation complete!"
