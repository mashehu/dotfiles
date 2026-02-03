#!/usr/bin/env bash
set -euo pipefail

if command -v cargo >/dev/null 2>&1; then
    echo "Checking Cargo packages..."

    # Check if cargo-update is available for smarter installation
    if cargo install-update --help >/dev/null 2>&1; then
        # Use cargo-update for idempotent installation
        cargo install-update --list
    else
        echo "Note: Consider installing cargo-update for better package management:"
        echo "  cargo install cargo-update"
        echo ""
        echo "Skipping cargo install to avoid reinstalling existing packages."
        echo "Run 'cargo install <package>' manually for new packages."
    fi
else
    echo "Cargo not found, skipping Rust package installation."
fi
