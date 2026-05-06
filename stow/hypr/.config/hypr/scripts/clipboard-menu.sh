#!/usr/bin/env bash
set -euo pipefail

notify() {
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "Clipboard" "$1"
  fi
}

if ! command -v rofi >/dev/null 2>&1; then
  printf 'rofi is not installed. Install rofi-wayland.\n' >&2
  exit 1
fi

if ! command -v cliphist >/dev/null 2>&1 || ! command -v wl-copy >/dev/null 2>&1; then
  printf 'cliphist and wl-copy are required for clipboard history.\n' >&2
  exit 1
fi

history="$(cliphist list 2>/dev/null || true)"

if [[ -z "$history" ]]; then
  notify "No clipboard history yet"
  exit 0
fi

selection="$(
  printf '%s\n' "$history" |
    rofi -dmenu -i -no-show-icons -matching fuzzy -p "clipboard" \
      -theme "$HOME/.config/rofi/themes/clipboard.rasi" || true
)"

if [[ -z "$selection" ]]; then
  exit 0
fi

printf '%s' "$selection" | cliphist decode | wl-copy
notify "Copied selection"
