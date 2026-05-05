# SwayNC MVP

This layer provides the notification daemon, notification popups, and a lightweight right-side notification center for the stage-1 desktop.

It is intentionally not a full dashboard. The future custom control center belongs in Quickshell after the MVP is stable.

## Apply

From the repository root:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" swaync
```

## Restart

```bash
pkill swaync
swaync &
```

Reload config and CSS without a full restart when supported:

```bash
swaync-client --reload-config
swaync-client --reload-css
```

## Test

```bash
notify-send "Glassy notification" "SwayNC theme test"
notify-send -u critical "Critical notification" "Muted red critical state"
```

## Toggle Notification Center

If the Hypr module is also stowed:

```bash
~/.config/hypr/scripts/notification-center.sh
```

Default keybind:

```text
SUPER + N
```

## Integration

Hyprland autostart launches `swaync`. The helper script uses `swaync-client -t -sw` to toggle the center and exits cleanly if `swaync-client` is missing.

Waybar is unchanged in this milestone.

## Known Limitations

- This is a notification center, not the final dashboard.
- Widget support can vary by SwayNC version; the config sticks to common widgets.
- If a widget key is unsupported on the installed SwayNC version, remove that widget from `config.json` and keep notifications working.
- Quickshell will eventually own richer dashboard behavior.

