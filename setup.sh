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
    [ "$f" = "setup.sh" ] && continue
    [ "$f" = "Brewfile" ] && continue
    [ "$f" = "README.md" ] && continue
    [ "$f" = "CLAUDE.md" ] && continue

    target="$HOME/$f"
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
