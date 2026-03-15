# dotfiles Project Guidelines

This document defines the rules, objectives, and progress management methods for the dotfiles project.

## Project Overview

This repository manages configuration files for CLI development environments used on macOS.

### Managed Configurations

- fish shell
- neovim
- karabiner
- ghostty
- zellij
- Other CLI development tool configurations

### Branch Strategy

- Platform-specific branches for managing configurations
- `macos`: macOS environment configurations
- `master`: Main branch
- Previously aimed for cross-platform compatibility, but now maintains platform-specific configurations

## Setup

Use `setup.sh` to create symbolic links (note: maintenance status may vary):

```bash
./setup.sh
```

This script creates symbolic links from the current directory to `$HOME` for configuration files.

## Git Rules

### Commit Messages

- Write in English
- Keep descriptions concise and clear
- Examples:
  - `Add alacritty config`
  - `Update karabiner config`
  - `Fix vim install way and add sound options`

### Commit Guidelines

- Do not commit unnecessary files
- Be careful with backup files (`.backup`, etc.)
- Exclude configuration files containing sensitive information
- Environment-specific or company-specific settings must be placed in local config files (not tracked in git):
  - fish: `~/.config/fish/config.local.fish`
  - git: `~/.config/git/local.gitconfig`

## Editing Rules

### File Operations

- Prefer editing existing configuration files over creating new ones
- Create new files only when absolutely necessary
- Be careful not to break symbolic link structures

### Coding Standards

- Avoid hard-coding; use environment variables or configuration files
- Clearly comment platform-specific configurations
- Delete obsolete configurations instead of leaving them commented out

## Project Management

- Place tool configurations under the `.config/` directory
- Delete or clearly archive old configuration files that are no longer needed
- Regularly review configurations that are no longer in use
