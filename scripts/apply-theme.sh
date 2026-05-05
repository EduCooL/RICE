#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
THEME_DIR="$REPO_ROOT/themes"

required=(
  colors.json
  colors.conf
  colors.css
  colors.rasi
  colors.sh
  colors.qml
)

missing=0

for file in "${required[@]}"; do
  if [[ -f "$THEME_DIR/$file" ]]; then
    printf '[OK] %s\n' "$THEME_DIR/$file"
  else
    printf '[WARN] Missing theme file: %s\n' "$THEME_DIR/$file"
    missing=1
  fi
done

if (( missing == 0 )); then
  printf '\nTheme files are present.\n'
  printf 'Future milestones will wire these tokens into Hyprland, Waybar, Rofi, SwayNC, Kitty, Starship, GTK, Qt, Hyprlock, and Quickshell.\n'
else
  printf '\nSome theme files are missing. Recreate them before applying configs.\n'
fi

