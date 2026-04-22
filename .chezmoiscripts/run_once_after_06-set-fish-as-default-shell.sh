#!/usr/bin/env bash
set -euo pipefail

FISH_PATH="/opt/homebrew/bin/fish"

if ! command -v fish >/dev/null 2>&1; then
    echo "Fish shell not found, skipping."
    exit 0
fi

if [ "$SHELL" = "$FISH_PATH" ]; then
    echo "Fish is already the default shell."
    exit 0
fi

if ! grep -qF "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

chsh -s "$FISH_PATH"
echo "Default shell set to fish."
