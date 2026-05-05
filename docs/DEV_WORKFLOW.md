# Development Workflow

This repo is intended for daily coding, university work, Git, Docker/PostgreSQL development, terminal usage, and general desktop work.

## Daily Checks

```bash
./scripts/check-health.sh
./scripts/dev-health.sh
./scripts/dotstatus.sh
```

## Useful Shell Aliases

The Zsh module adds conditional aliases for:

- `g`, `gs`, `ga`, `gc`, `gp`, `gl`, `gd`
- `ll`, `la`, `lt` when `eza` exists
- `cat` through `bat` when available
- `grep` through `rg` when available
- `find` through `fd` when available

No plugin manager is required.

## Dotfiles Update Routine

```bash
cd ~/dotfiles
./scripts/dotpull.sh
```

If you work from a different clone path, set:

```bash
export DOTFILES_DIR=/path/to/dotfiles
```

## Stage-1 Scope

Stage 1 keeps tooling simple and reliable. Deeper editor setup, custom dashboards, and Quickshell belong to later stages.

