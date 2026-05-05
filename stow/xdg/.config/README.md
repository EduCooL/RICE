# GTK, Qt, XDG, And File Manager MVP

This module documents the desktop app integration layer:

- GTK settings prefer `Adwaita-dark`, `Papirus-Dark`, and Inter.
- Qt settings prefer `qt5ct`/`qt6ct` with Kvantum.
- Kvantum includes a minimal local `CozyRain` theme stub.
- XDG user directories use standard English names.
- MIME defaults keep Firefox for web links and Thunar for directories.
- Thunar custom actions live in the separate `thunar` module.

## Apply

From the repository root:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" gtk qt xdg thunar
```

Then initialize user directories:

```bash
xdg-user-dirs-update
```

## GUI Tools

Use these tools for final manual selection and inspection:

```bash
nwg-look
qt5ct
qt6ct
kvantummanager
```

Recommended selections:

- GTK theme: `Adwaita-dark`
- Icon theme: `Papirus-Dark`
- Font: `Inter 10`
- Cursor: `Bibata-Modern-Ice` if installed, otherwise keep system default
- Qt style: `Kvantum`
- Kvantum theme: `CozyRain`

## Notes

`QT_STYLE_OVERRIDE=kvantum` is set in Hyprland environment config. If a Qt app behaves badly, comment that line in `~/.config/hypr/conf/env.conf` and reload Hyprland.

The Kvantum theme is intentionally minimal. Final Qt polish can be done manually in `kvantummanager` or in a later theme refinement milestone.

