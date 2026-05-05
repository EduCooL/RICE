# Kitty MVP

This module provides the terminal foundation for the rice: a readable dark graphite Kitty config, project palette, moderate transparency, comfortable padding, and practical development defaults.

## Apply

From the repository root:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" kitty
```

## Test

```bash
kitty
kitty --debug-config
```

## Font

The config expects:

```text
JetBrainsMono Nerd Font
```

Install package:

```bash
sudo pacman -S --needed ttf-jetbrains-mono-nerd
```

## Theme Notes

- `kitty.conf` contains behavior and UI settings.
- `theme.conf` contains the palette.
- Background opacity is `0.92`: translucent enough to match the rice, but not so transparent that code becomes hard to read.

