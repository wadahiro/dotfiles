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

    ln -snfv "$SCRIPT_DIR/$f" "$HOME/$f"
done
