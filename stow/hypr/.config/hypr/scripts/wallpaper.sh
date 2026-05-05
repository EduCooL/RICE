#!/usr/bin/env bash
set -euo pipefail

wallpaper="$HOME/Pictures/Wallpapers/current"

notify() {
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "Wallpaper" "$1"
  fi
}

if [[ ! -e "$wallpaper" ]]; then
  printf 'No wallpaper found at: %s\n' "$wallpaper"
  printf 'Create a file or symlink named current in ~/Pictures/Wallpapers/.\n'
  printf 'Example: ln -sf /path/to/wallpaper.png "$HOME/Pictures/Wallpapers/current"\n'
  notify "Missing $wallpaper"
  exit 0
fi

if ! command -v hyprpaper >/dev/null 2>&1; then
  printf 'hyprpaper is not installed.\n' >&2
  notify "hyprpaper is not installed"
  exit 1
fi

if ! pgrep -x hyprpaper >/dev/null 2>&1; then
  hyprpaper >/dev/null 2>&1 &
  sleep 0.4
fi

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl hyprpaper preload "$wallpaper" >/dev/null 2>&1 || true
  hyprctl hyprpaper wallpaper ",$wallpaper,cover" >/dev/null 2>&1 || true
fi

printf 'Wallpaper applied: %s\n' "$wallpaper"
notify "$wallpaper"
