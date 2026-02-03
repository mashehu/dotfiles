#!/usr/bin/env bash
set -euo pipefail

if command -v brew >/dev/null 2>&1; then
    FZF_INSTALL="$(brew --prefix)/opt/fzf/install"

    if [ -f "$FZF_INSTALL" ]; then
        echo "Installing FZF key bindings and fuzzy completion..."
        # --all: Enable all features
        # --no-bash: Skip bash (using zsh/fish)
        # --no-update-rc: Don't modify shell configs (already in dotfiles)
        "$FZF_INSTALL" --all --no-bash --no-update-rc
    else
        echo "FZF install script not found at $FZF_INSTALL"
        exit 1
    fi
else
    echo "Homebrew not found, skipping FZF installation."
    exit 1
fi
