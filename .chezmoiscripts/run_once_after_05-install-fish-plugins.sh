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

# Install all plugins from fish_plugins file
FISH_PLUGINS_FILE="$HOME/.config/fish/fish_plugins"
if [ -f "$FISH_PLUGINS_FILE" ]; then
    echo "Syncing plugins from fish_plugins file..."
    fish -c "fisher update"
else
    echo "Warning: fish_plugins file not found at $FISH_PLUGINS_FILE"
fi

echo "Fish plugins installation complete!"
