# Personal Arch Hyprland Dotfiles

## Concept

This repository is the bootstrap foundation for a personal Arch Linux Hyprland rice built from scratch.

The target mood is a cozy dark room on a rainy evening: graphite and forest-black surfaces, muted teal and sage accents, warm amber highlights, translucent rounded panels, and low visual noise. The goal is a daily usable development desktop, not a screenshot-only setup.

This milestone only creates the repository structure, package manifests, theme tokens, and safe setup scripts. Full Hyprland, Waybar, Rofi, SwayNC, Kitty, Zsh, Starship, lock screen, and wallpaper configs will be added in later milestones.

## Stack

Planned core stack:

- Hyprland for the Wayland compositor
- Waybar as the stage-1 shell/bar
- Rofi Wayland for launcher, power menu, clipboard, and window switching
- SwayNC for notifications
- Kitty for terminal
- Zsh and Starship for shell prompt
- GNU Stow for dotfiles management
- Hyprpaper, Hyprlock, and Hypridle for wallpaper, lock, and idle

Quickshell is a future direction and is not implemented in this bootstrap milestone.

## Repository Layout

- `packages/` contains package lists split by package source and optionality.
- `scripts/` contains safe setup helpers.
- `stow/` contains future GNU Stow modules.
- `themes/` contains shared color tokens in multiple formats.
- `wallpapers/` documents the wallpaper path convention.

## Installation

Run from the repository root:

```bash
./install.sh
```

The installer does not install packages automatically. It checks for `stow`, backs up conflicting user configs, stows current modules, and runs a health report.

## Package Installation

To review and install the main Pacman packages:

```bash
./scripts/install-packages.sh
```

The script prints the package list and asks before running `sudo pacman -S --needed`.

AUR and Flatpak packages are listed separately and are optional:

- `packages/aur.txt`
- `packages/flatpak.txt`

## Stow Usage

Stow all modules:

```bash
./scripts/stow-all.sh
```

The script uses:

```bash
stow --dir="$REPO_ROOT/stow" --target="$HOME" "$module"
```

## Backup Behavior

Before stowing, run:

```bash
./scripts/backup-existing-configs.sh
```

Conflicting files and directories are moved to:

```text
~/.dotfiles-backups/YYYY-MM-DD_HH-MM-SS/
```

The script does not delete user files and skips symlinks that already point into this repository.

## Theme System

Theme tokens live in `themes/`:

- `colors.json`
- `colors.conf`
- `colors.css`
- `colors.rasi`
- `colors.sh`
- `colors.qml`

Future configs should import or generate from these values so Hyprland, Waybar, Rofi, SwayNC, Kitty, Starship, GTK, Qt, Hyprlock, scripts, and Quickshell stay visually consistent.

## Keybinds

The keybind map will be added with the modular Hyprland MVP config.

Planned main modifier: `SUPER`.

## Wallpaper Convention

Wallpapers should live under:

```text
~/Pictures/Wallpapers/
```

The planned default path for configs is:

```text
~/Pictures/Wallpapers/cozy-rainy-study.jpg
```

Large wallpaper binaries are not committed by default.

## Health Check

Run:

```bash
./scripts/check-health.sh
```

The report warns about missing commands or inactive services but exits with status `0`.

## Roadmap

1. Bootstrap repository foundation.
2. Implement modular Hyprland MVP config and core scripts.
3. Add Waybar, Rofi, SwayNC, Kitty, Zsh, Starship, Hyprlock, Hyprpaper, GTK, and Qt configs.
4. Refine dashboard behavior and project launcher.
5. Prepare a small Quickshell prototype after the MVP is comfortable.

## Rollback / Recovery

Backups created by `scripts/backup-existing-configs.sh` are stored under:

```text
~/.dotfiles-backups/
```

To roll back a config, unstow the relevant module and move the backed-up file or directory back into place.

