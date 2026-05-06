#!/usr/bin/env bash
set -euo pipefail

# rofi-wayland provides the rofi binary on Arch.
if ! command -v rofi >/dev/null 2>&1; then
  printf 'rofi is not installed. Install rofi-wayland.\n' >&2
  exit 1
fi

rofi \
  -show drun \
  -matching fuzzy \
  -sort \
  -theme "$HOME/.config/rofi/themes/launcher.rasi"
