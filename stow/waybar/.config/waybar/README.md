# Waybar MVP

This is the temporary stage-1 shell for the rice. It provides a compact, usable top bar while the rest of the desktop is built incrementally. The long-term replacement path is a custom Quickshell shell, but Waybar stays the stable fallback until that shell is complete.

## Apply

From the repository root:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" waybar
```

## Restart

```bash
pkill waybar
waybar &
```

The Hypr reload helper also restarts Waybar:

```bash
~/.config/hypr/scripts/reload.sh
```

## Layout

- Left: launcher and Hyprland workspaces
- Center: focused window title
- Right: tray, updates, network, audio, battery, clipboard, clock, power

## Hypr Integration

Waybar uses existing Hypr helper scripts for interactive actions:

- launcher: `~/.config/hypr/scripts/launcher.sh`
- clipboard: `~/.config/hypr/scripts/clipboard-menu.sh`
- power: `~/.config/hypr/scripts/power-menu.sh`

Rofi is intentionally not themed here. Rofi styling comes in the next milestone.

## Palette

`style.css` duplicates the shared palette from `themes/colors.css` for now. Future work should generate or import these values through `scripts/apply-theme.sh` so all components stay in sync.

## Known Limitations

- Rofi menus still use default styling until the Rofi milestone.
- SwayNC notifications are not styled yet.
- Bluetooth uses tray support for now; no custom Bluetooth module is configured.
- The updates module uses `checkupdates` only if available and never installs packages.
- Quickshell is not implemented yet.

