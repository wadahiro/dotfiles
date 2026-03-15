#!/bin/bash

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages from Brewfile
brew bundle --file="$(cd "$(dirname "$0")" && pwd)/Brewfile"

# Create symbolic links
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
for f in $(find "$SCRIPT_DIR" -maxdepth 1 -mindepth 1 | awk -F/ '{print $NF}'); do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue
    [ "$f" = "setup.sh" ] && continue
    [ "$f" = "Brewfile" ] && continue
    [ "$f" = "README.md" ] && continue
    [ "$f" = "CLAUDE.md" ] && continue
    # Skip files ignored by git
    git -C "$SCRIPT_DIR" check-ignore -q "$f" 2>/dev/null && continue

    target="$HOME/$f"
    # Skip if symlink already points to the correct location
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$SCRIPT_DIR/$f" ]; then
        continue
    fi
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        read -p "$target already exists. Backup and replace? [y/N] " answer
        if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
            echo "Skipping $f"
            continue
        fi
        mv -v "$target" "$target.backup"
    fi
    ln -snfv "$SCRIPT_DIR/$f" "$target"
done

# Install fisher and fish plugins (after symlinks so fish_plugins is available)
if command -v fish &> /dev/null; then
    fish -c "type -q fisher" 2>/dev/null || fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
    fish -c "fisher update"
fi

# Install mise tools (after symlinks so config.toml is available)
if command -v mise &> /dev/null; then
    mise install
fi

# Configure Docker CLI plugins (docker compose etc.)
mkdir -p "$HOME/.docker"
if [ -f "$HOME/.docker/config.json" ]; then
    # Add cliPluginsExtraDirs if not already present
    if ! grep -q cliPluginsExtraDirs "$HOME/.docker/config.json"; then
        tmp=$(mktemp)
        jq '. + {"cliPluginsExtraDirs": ["/opt/homebrew/lib/docker/cli-plugins"]}' "$HOME/.docker/config.json" > "$tmp" && mv "$tmp" "$HOME/.docker/config.json"
    fi
else
    echo '{"cliPluginsExtraDirs": ["/opt/homebrew/lib/docker/cli-plugins"]}' > "$HOME/.docker/config.json"
fi

# macOS settings
# Disable startup sound
if ! nvram StartupMute 2>/dev/null | grep -q '%01'; then
    sudo nvram StartupMute=%01
fi

# Finder: show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Finder: default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Finder: show full path in title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# Keyboard: fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
# Keyboard: short delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Dock: auto-hide
defaults write com.apple.dock autohide -bool true
# Disable .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Screenshot: save to ~/Screenshots
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
# Screenshot: disable window shadow
defaults write com.apple.screencapture disable-shadow -bool true

# Apply changes
killall Finder
killall Dock
killall SystemUIServer
