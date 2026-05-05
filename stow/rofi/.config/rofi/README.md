# Rofi MVP

This layer provides the temporary menu UI for the stage-1 desktop:

- app launcher
- power menu
- clipboard history
- window switcher

Rofi is used as a practical MVP while the future Quickshell shell is not implemented.

## Apply

From the repository root:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" rofi hypr
```

The `hypr` module is restowed because its helper scripts call these themes.

## Themes

- `themes/shared.rasi`: common palette and base widgets
- `themes/launcher.rasi`: `rofi -show drun`
- `themes/power-menu.rasi`: power and confirmation menus
- `themes/clipboard.rasi`: `cliphist` selection
- `themes/window.rasi`: `rofi -show window`

The shared theme currently duplicates palette values from `themes/colors.rasi`. Future work should generate or import the shared Rasi palette through `scripts/apply-theme.sh`.

## Hypr Integration

Hypr helper scripts call Rofi:

- `~/.config/hypr/scripts/launcher.sh`
- `~/.config/hypr/scripts/clipboard-menu.sh`
- `~/.config/hypr/scripts/power-menu.sh`
- `~/.config/hypr/scripts/window-menu.sh`

Waybar click actions continue to call the same Hypr scripts.

## Test

```bash
~/.config/hypr/scripts/launcher.sh
~/.config/hypr/scripts/clipboard-menu.sh
~/.config/hypr/scripts/power-menu.sh
~/.config/hypr/scripts/window-menu.sh
```

## Known Limitations

- SwayNC is not themed yet.
- Rofi remains a temporary UI for several flows until a future Quickshell shell exists.
- The theme expects `JetBrainsMono Nerd Font` and a dark icon theme such as `Papirus-Dark`.

