#!/usr/bin/env bash
set -euo pipefail

wallpaper="$HOME/Pictures/Wallpapers/current"

if [[ ! -e "$wallpaper" ]]; then
  printf 'No wallpaper found at: %s\n' "$wallpaper"
  printf 'Create a file or symlink named current in ~/Pictures/Wallpapers/.\n'
  exit 0
fi

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl hyprpaper unload all >/dev/null 2>&1 || true
  hyprctl hyprpaper preload "$wallpaper" >/dev/null 2>&1 || true
  hyprctl hyprpaper wallpaper ",$wallpaper" >/dev/null 2>&1 || true
fi

if ! pgrep -x hyprpaper >/dev/null 2>&1; then
  hyprpaper >/dev/null 2>&1 &
fi

if command -v notify-send >/dev/null 2>&1; then
  notify-send "Wallpaper" "$wallpaper"
fi

