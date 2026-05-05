# Personal Arch Hyprland Dotfiles

## Concept

This repository is the bootstrap foundation for a personal Arch Linux Hyprland rice built from scratch.

The target mood is a cozy dark room on a rainy evening: graphite and forest-black surfaces, muted teal and sage accents, warm amber highlights, translucent rounded panels, and low visual noise. The goal is a daily usable development desktop, not a screenshot-only setup.

The bootstrap milestone created the repository structure, package manifests, theme tokens, and safe setup scripts. The Hyprland MVP now adds the first working compositor layer. Waybar, Rofi, SwayNC, Kitty, Zsh, Starship, GTK, Qt, and Quickshell styling will be added in later milestones.

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

Stow only Hyprland:

```bash
stow --dir="$PWD/stow" --target="$HOME" hypr
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

Main modifier: `SUPER`.

Core Hyprland MVP bindings:

- `SUPER + Return`: terminal
- `SUPER + D`: launcher
- `SUPER + E`: file manager
- `SUPER + B`: browser
- `SUPER + Q`: close focused window
- `SUPER + F`: fullscreen
- `SUPER + Space`: toggle floating
- `SUPER + V`: clipboard history
- `SUPER + L`: lock
- `SUPER + Shift + S`: screenshot area
- `SUPER + Print`: full screenshot
- `SUPER + Shift + Q`: power menu
- `SUPER + R`: reload Hyprland helper
- `SUPER + 1-6`: switch workspace
- `SUPER + Shift + 1-6`: move focused window to workspace
- `SUPER + arrows`: focus windows
- `SUPER + Shift + arrows`: move windows

## Wallpaper Convention

Wallpapers should live under:

```text
~/Pictures/Wallpapers/
```

The planned default path for configs is:

```text
~/Pictures/Wallpapers/current
```

Large wallpaper binaries are not committed by default.

## Hyprland MVP

The Hyprland module lives at:

```text
stow/hypr/.config/hypr/
```

It is split into:

- `hyprland.conf` as the small entrypoint
- `conf/` for environment, monitors, input, decoration, animations, gestures, workspaces, window rules, keybinds, and autostart
- `scripts/` for screenshots, launcher, clipboard menu, power menu, reload, night mode placeholder, and wallpaper helper
- `hyprlock.conf` and `hyprpaper.conf`

To stow only this module:

```bash
stow --dir="$PWD/stow" --target="$HOME" hypr
```

To reload after changes:

```bash
~/.config/hypr/scripts/reload.sh
```

Screenshot behavior:

- area screenshots use `grim`, `slurp`, and `wl-copy`
- full screenshots use `grim` and `wl-copy`
- files are saved to `~/Pictures/Screenshots/`
- screenshots are copied to the clipboard
- `notify-send` is used only if available

Clipboard behavior:

- `wl-paste` watchers are started by Hyprland autostart
- `SUPER + V` opens `cliphist list` through `rofi -dmenu`
- the selected item is decoded with `cliphist decode` and copied with `wl-copy`

Known Hyprland MVP limitations:

- Waybar is started but not styled yet
- Rofi is used without project themes yet
- SwayNC is started but not themed yet
- night mode is a placeholder
- wallpaper files are local-only and not committed
- Quickshell is intentionally not implemented yet

Next step: implement Waybar MVP styling and status modules according to the cozy dark reference.

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
