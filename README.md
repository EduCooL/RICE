# Personal Arch Hyprland Dotfiles

## Concept

This repository is the bootstrap foundation for a personal Arch Linux Hyprland rice built from scratch.

The target mood is a cozy dark room on a rainy evening: graphite and forest-black surfaces, muted teal and sage accents, warm amber highlights, translucent rounded panels, and low visual noise. The goal is a daily usable development desktop, not a screenshot-only setup.

The bootstrap milestone created the repository structure, package manifests, theme tokens, and safe setup scripts. The current MVP includes Hyprland, Waybar, Rofi, SwayNC, Kitty, Zsh, Starship, GTK, Qt, XDG, and file manager foundations. Deeper app polish and Quickshell will be added in later milestones.

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

Quickshell is a future direction and is not implemented yet.

## Current Stage

Stage 1 — functional MVP.

The goal of this stage is reliability: install packages, stow modules, reload Hyprland, launch core tools, recover from conflicts, and keep the repo maintainable. Visual unification comes next.

## Fresh Install Flow

From a fresh Arch install with this repo cloned:

```bash
./scripts/install-packages.sh
./scripts/backup-existing-configs.sh
./scripts/stow-all.sh
./scripts/check-health.sh
hyprctl reload
```

Set a local wallpaper:

```bash
mkdir -p ~/Pictures/Wallpapers
ln -sf /path/to/my-wallpaper.png ~/Pictures/Wallpapers/current
~/.config/hypr/scripts/wallpaper.sh
```

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

For explicit Stage-1 apply steps, prefer:

```bash
./scripts/backup-existing-configs.sh
./scripts/stow-all.sh
./scripts/check-health.sh
hyprctl reload
```

## Package Installation

To review and install the main Pacman packages:

```bash
./scripts/install-packages.sh
```

The script prints the package list and asks before running `sudo pacman -S --needed`.

AUR and Flatpak packages are listed separately and are optional:

- `packages/aur.txt`
- `packages/flatpak.txt`

NVIDIA-specific packages are not installed automatically. Keep GPU notes and driver decisions machine-specific.

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
- `SUPER + Tab`: window switcher
- `SUPER + N`: notification center
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

The rice will not resemble the reference with a bright outdoor/daylight wallpaper. Use a dark rainy interior, night city window, study room, library, or desk wallpaper with small warm amber light sources. Avoid anime, cyberpunk neon, bright skies, saturated blues, and flat daylight scenes.

Apply/reload the wallpaper:

```bash
~/.config/hypr/scripts/wallpaper.sh
```

Hyprlock uses a blurred screenshot so it still works if the wallpaper path is missing.

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

If `~/.config/hypr/scripts/clipboard-menu.sh` or another helper script is missing after pulling new repo changes, restow the module:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" hypr
```

If Stow reports conflicts, run the backup helper first:

```bash
./scripts/backup-existing-configs.sh
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

- Waybar is a stage-1 shell and remains a future Quickshell fallback
- Rofi is themed but remains a temporary menu layer
- SwayNC is themed but remains a temporary notification center
- night mode is a placeholder
- wallpaper files are local-only and not committed
- Quickshell is intentionally not implemented yet

Stage-1 status: Hyprland is functional and integrated with Waybar, Rofi, SwayNC, Kitty, shell, GTK/Qt, XDG, and Thunar modules.

## Waybar MVP

The Waybar module lives at:

```text
stow/waybar/.config/waybar/
```

Apply or refresh it with:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" waybar
```

Restart Waybar directly:

```bash
pkill waybar
waybar &
```

Or use the Hyprland reload helper, which reloads Hyprland and restarts Waybar:

```bash
~/.config/hypr/scripts/reload.sh
```

Waybar layout:

- left: launcher and workspaces
- center: focused window title
- right: tray, updates, network, audio, battery, clipboard, clock, power

Waybar integrates with the existing Hypr scripts:

- `custom/launcher`: `~/.config/hypr/scripts/launcher.sh`
- `custom/clipboard`: `~/.config/hypr/scripts/clipboard-menu.sh`
- `custom/power`: `~/.config/hypr/scripts/power-menu.sh`

Waybar and Rofi are temporary stage-1 components; the future custom shell direction remains Quickshell after the MVP is stable.

## Rofi MVP

The Rofi module lives at:

```text
stow/rofi/.config/rofi/
```

Apply or refresh Rofi and the Hypr scripts that call it:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" rofi hypr
```

Test the menus:

```bash
~/.config/hypr/scripts/launcher.sh
~/.config/hypr/scripts/clipboard-menu.sh
~/.config/hypr/scripts/power-menu.sh
~/.config/hypr/scripts/window-menu.sh
```

Rofi provides the temporary app launcher, clipboard menu, power menu, and window switcher. It uses the same graphite, muted teal, sage, and amber palette as Waybar, but the palette is duplicated in `themes/shared.rasi` until `scripts/apply-theme.sh` can generate/import Rasi tokens automatically.

Power actions are guarded: reboot and shutdown require confirmation. Rofi remains temporary for some UI flows until a future custom Quickshell shell exists.

## SwayNC MVP

The SwayNC module lives at:

```text
stow/swaync/.config/swaync/
```

Apply or refresh it with:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" swaync
```

If you also want the `SUPER + N` notification-center helper:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" swaync hypr
hyprctl reload
```

Restart SwayNC:

```bash
pkill swaync
swaync &
```

Test notifications:

```bash
notify-send "Glassy notification" "SwayNC theme test"
```

Toggle the notification center:

```bash
~/.config/hypr/scripts/notification-center.sh
```

SwayNC is the temporary notification center and lightweight control center. It keeps the dark graphite, muted teal, sage border, and warm amber visual language without trying to become the final Quickshell dashboard.

## Terminal And Shell MVP

Terminal and shell modules:

```text
stow/kitty/.config/kitty/
stow/zsh/
stow/starship/.config/starship.toml
```

Apply or refresh them with:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" kitty zsh starship
```

Switch the login shell to Zsh:

```bash
chsh -s "$(command -v zsh)"
```

Test the layer:

```bash
kitty
zsh
starship explain
```

The shell foundation is intentionally lightweight: no Oh My Zsh, no external plugin manager, and optional integrations only when the relevant command exists. Starship provides a compact prompt with directory, Git state, selected language runtimes, Docker context, command duration, and success/error character color.

## GTK/Qt And File Manager MVP

Desktop integration modules:

```text
stow/gtk/
stow/qt/
stow/xdg/
stow/thunar/
```

Apply or refresh them with:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" gtk qt xdg thunar
```

Apply XDG user directories:

```bash
xdg-user-dirs-update
```

Open GUI configuration tools:

```bash
nwg-look
qt5ct
qt6ct
kvantummanager
```

Recommended manual selections:

- GTK theme: `Adwaita-dark`
- Icons: `Papirus-Dark`
- Font: `Inter 10`
- Qt style: `Kvantum`
- Kvantum theme: `CozyRain`

Known limitations: the Kvantum theme is a minimal local stub, not a full polished theme. Cursor theme is set to `Bibata-Modern-Ice` in GTK settings if installed; otherwise select an available cursor through `nwg-look`.

Qt integration is not automatic magic. The Hyprland environment defaults to `QT_QPA_PLATFORMTHEME=qt6ct` plus `QT_STYLE_OVERRIDE=kvantum` for modern Qt apps. If a Qt5-only app still looks like a Windows/default style, test it from a shell with:

```bash
QT_QPA_PLATFORMTHEME=qt5ct QT_STYLE_OVERRIDE=kvantum app-name
```

Then verify both `qt5ct` and `qt6ct` manually:

```text
Style: Kvantum
Icons: Papirus-Dark
Font: Inter 10
Kvantum theme: CozyRain
```

For better Thunar matching, open `nwg-look` and verify:

```text
GTK theme: Adwaita-dark or another installed dark theme
Icons: Papirus-Dark
Font: Inter 10 or Inter 11
Cursor: any available dark cursor
```

Thunar is still a GTK application and will not perfectly match the reference until a stronger GTK theme/icon pack is selected locally.

## Health Check

Run:

```bash
./scripts/check-health.sh
```

The report warns about missing commands or inactive services but exits with status `0`.

## Updating From GitHub

Safe update:

```bash
./scripts/dotpull.sh
```

If local changes exist, the script refuses to pull. Inspect them:

```bash
./scripts/dotstatus.sh
```

Options when Git says local changes would be overwritten:

- commit local changes with `git add` and `git commit`;
- stash and reapply with `./scripts/dotpull.sh --stash`;
- discard individual files manually with `git restore <file>` only after review.

See `docs/DOTFILES_MAINTENANCE.md`.

## Troubleshooting

Hyprland reload errors:

```bash
hyprctl reload
```

Read the exact error, fix the named file, then reload again.

Stow conflicts:

```bash
./scripts/backup-existing-configs.sh
./scripts/stow-all.sh
```

Missing `~/.config/hypr/scripts/*.sh`:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" hypr
chmod +x ~/.config/hypr/scripts/*.sh
```

Waybar not starting:

```bash
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
```

Rofi not themed:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" rofi hypr
~/.config/hypr/scripts/launcher.sh
```

SwayNC not restarting:

```bash
pkill swaync
swaync &
swaync-client --reload-css
```

Hyprlock failing:

```bash
hyprlock -c ~/.config/hypr/hyprlock.conf
```

Wallpaper missing:

```bash
mkdir -p ~/Pictures/Wallpapers
ln -sf /path/to/my-wallpaper.png ~/Pictures/Wallpapers/current
~/.config/hypr/scripts/wallpaper.sh
```

Docker permission denied:

```bash
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"
```

Log out and back in.

PostgreSQL port `5432` busy:

```bash
ss -ltnp | grep ':5432'
docker ps
```

See `docs/DOCKER_POSTGRES.md`.

## Known Limitations

- Stage 1 prioritizes working components over perfect visual alignment.
- The Kvantum theme is a minimal local stub.
- Wallpaper assets are user-provided and not committed.
- Quickshell is not part of Stage 1.

## Next Stage

Stage 2 — visual unification.

Next work should align palette, spacing, radius, borders, opacity, blur, and typography across Hyprland, Waybar, Rofi, SwayNC, Kitty, Hyprlock, GTK, and Qt.

## Stage 2 — Visual Unification

This pass aligns the existing Stage-1 components without adding new major features.

## Stage 2 visual correction

This pass corrected the first visual unification attempt to better match the cozy rainy reference: graphite/green-black surfaces, sage active states, warm amber highlights, compact spacing, subtle borders, and consistent radius.

## Stage 2 hard visual reset

This pass fixes the first failed visual direction: removes bright cyan/light-blue treatment, fixes broken Rofi power icons, darkens SwayNC/Waybar surfaces, and documents the wallpaper requirements needed to match the cozy rainy reference.

## Stage 2 forensic correction

This pass fixes concrete mismatches seen in real screenshots: removes the remaining cyan/light-blue treatment, darkens Rofi inputs, improves clipboard/power menu behavior, clarifies GTK/Qt manual integration, and reinforces the wallpaper requirements needed for the intended cozy rainy look.

Forensic reset scope:

- Waybar CSS was rebuilt as dark graphite island modules instead of a tinted strip.
- Rofi shared and mode themes were rebuilt as compact command palettes with dark inputs.
- Clipboard history exits cleanly when empty instead of opening a large blank panel.
- SwayNC CSS was rebuilt as a compact right-side graphite glass panel.
- GTK CSS now darkens conservative baseline controls used by Thunar and theme tools.
- Qt config now consistently prefers Kvantum and portal dialogs, with manual `qt5ct`/`qt6ct` verification still required.

Aligned areas:

- shared `surface_*` semantic tokens across theme files
- 1px subtle sage borders
- 8/12/14/16px radius scale
- compact 6/8/12px padding scale
- muted teal active/selection states
- amber warnings and muted red critical states
- consistent dark glass surfaces for Waybar, Rofi, SwayNC, Kitty, Hyprlock, GTK, and Qt references

Intentionally not done yet:

- no Quickshell implementation
- no new wallpaper assets
- no full GTK4/libadwaita override
- no large component redesign

Apply and reload:

```bash
./scripts/apply-theme.sh
./scripts/stow-all.sh
~/.config/hypr/scripts/reload.sh
```

Test visually:

```bash
./scripts/check-health.sh
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
~/.config/hypr/scripts/launcher.sh
notify-send "Theme test" "SwayNC visual check"
kitty
hyprlock -c ~/.config/hypr/hyprlock.conf
```

## Roadmap

1. Bootstrap repository foundation.
2. Implement modular Hyprland MVP config and core scripts.
3. Add Waybar, Rofi, SwayNC, Kitty, Zsh, Starship, Hyprlock, Hyprpaper, GTK, Qt, XDG, and file manager configs.
4. Add developer tooling polish and optional editor/file-manager basics.
5. Refine dashboard behavior and prepare a small Quickshell prototype after the MVP is comfortable.

## Rollback / Recovery

Backups created by `scripts/backup-existing-configs.sh` are stored under:

```text
~/.dotfiles-backups/
```

To roll back a config, unstow the relevant module and move the backed-up file or directory back into place.
