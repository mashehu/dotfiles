# My Dotfiles (managed via chezmoi)

Personal macOS configuration using [chezmoi](https://www.chezmoi.io/) for dotfile management and [Zim](https://zimfw.sh/) for Zsh configuration.

## Quick Start

### Installation

**One-line setup**:
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mashehu
```

Or, if you want to review changes first:
```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init mashehu
chezmoi diff  # Review changes
chezmoi apply -v
```
## Common Operations

### Update dotfiles from repository
```bash
cd ~/.dotfiles
git pull
chezmoi apply
```

### Edit a dotfile
```bash
chezmoi edit ~/.zshrc

# Or edit directly in source directory
cd ~/.dotfiles
zed dot_zshrc
```

### Add a new dotfile
```bash
chezmoi add ~/.newfile
```

### See what would change
```bash
chezmoi diff
```

### Apply changes
```bash
chezmoi apply -v
```

### Update packages
```bash
# Update Homebrew packages
brew update && brew upgrade

# Update Brewfile to match current installations
brew bundle dump --file=~/.dotfiles/brewfile --force
```
