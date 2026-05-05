#!/usr/bin/env bash
set -euo pipefail

if ! command -v rofi >/dev/null 2>&1; then
  printf 'rofi is not installed. Install rofi-wayland.\n' >&2
  exit 1
fi

rofi -show window -theme "$HOME/.config/rofi/themes/window.rasi"

