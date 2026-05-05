#!/usr/bin/env bash
set -euo pipefail

selection="$(cliphist list | rofi -dmenu -i -p "Clipboard" || true)"

if [[ -z "$selection" ]]; then
  exit 0
fi

printf '%s' "$selection" | cliphist decode | wl-copy

