# pnpm Global Packages

This directory manages pnpm global packages configuration.

## Installation

To install global packages defined in `global-packages.json`:

```bash
cd ~/.config/pnpm
pnpm install -g $(cat global-packages.json | jq -r '.dependencies | keys[]')
```

Or manually install each package:

```bash
pnpm add -g @anthropic-ai/claude-code
pnpm add -g aws-cdk
pnpm add -g npm-check-updates
```

## Update

To update all global packages:

```bash
pnpm update -g @anthropic-ai/claude-code aws-cdk npm-check-updates
```

## Managed Packages

- `@anthropic-ai/claude-code`: Claude Code CLI
- `aws-cdk`: AWS Cloud Development Kit CLI
- `npm-check-updates`: Tool to upgrade package.json dependencies
