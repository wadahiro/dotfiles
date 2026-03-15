# @wadahiro's dotfiles

macOS CLI development environment configuration files.

## Initial Setup

### 1. Clone this repository

Clone to the ghq-compatible directory so that `ghq` can manage it after setup:

```bash
mkdir -p ~/dev/src/github.com/wadahiro
git clone https://github.com/wadahiro/dotfiles.git ~/dev/src/github.com/wadahiro/dotfiles
cd ~/dev/src/github.com/wadahiro/dotfiles
git checkout macos
```

### 2. Run setup script

```bash
./setup.sh
```

This script will:

1. Install [Homebrew](https://brew.sh/) (if not installed)
2. Install packages from `Brewfile`
3. Create symbolic links to `$HOME` (with backup confirmation for existing files)

### 3. Post-setup

- Set fish as default shell: `chsh -s $(which fish)`
- Remove `~/.tool-versions` if migrating from asdf (now managed by mise)
- Add environment-specific settings to local config files (not tracked in git):
  - fish: `~/.config/fish/config.local.fish`
  - git: `~/.config/git/local.gitconfig`
