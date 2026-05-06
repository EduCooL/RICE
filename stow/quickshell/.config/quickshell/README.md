# Stage 3 Quickshell Prototype

This is the first custom shell prototype for the rice. It is intentionally parallel to the Stage-1 stack and does not replace Waybar, Rofi, or SwayNC yet.

## What It Provides

- custom top bar with launcher, workspaces, active window, status pills, clock, and dashboard toggle
- right-side dashboard prototype with system, clock, quick actions, and status cards
- theme tokens for colors, metrics, and typography
- small Hyprland, system, audio, and battery services
- reload and dashboard helper script placeholders

## Apply

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" quickshell
```

## Run Manually

```bash
quickshell
```

The expected entrypoint is:

```text
~/.config/quickshell/shell.qml
```

## Stop / Rollback

```bash
pkill quickshell
waybar &
```

Waybar remains the fallback bar.

## Dashboard

The dashboard is hidden by default. Start Quickshell and click the `dash` pill in the right status cluster.

`scripts/toggle-dashboard.sh` is a placeholder until a stable Quickshell IPC mechanism is selected for this shell.

## Known Limitations

- no system tray yet
- no notification replacement yet
- no clipboard UI replacement yet
- no real network manager integration yet
- CPU/RAM cards are placeholders
- dashboard toggle is in-QML only for now
- this prototype is meant for screenshots and iteration before replacing Waybar
