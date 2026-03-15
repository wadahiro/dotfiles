#!/bin/bash

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages from Brewfile
brew bundle --file="$(cd "$(dirname "$0")" && pwd)/Brewfile"

# Create symbolic links
pwd=$(cd "$(dirname "$0")" && pwd)
for f in $(find . -maxdepth 1 -mindepth 1 | awk -F/ '{print $NF}'); do
    [ "$f" = ".git" ] && continue
    [ "$f" = "setup.sh" ] && continue
    [ "$f" = "Brewfile" ] && continue
    [ "$f" = "README.md" ] && continue
    [ "$f" = "CLAUDE.md" ] && continue

    ln -snfv "$pwd/$f" "$HOME/$f"
done
