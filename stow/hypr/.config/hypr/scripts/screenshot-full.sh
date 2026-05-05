#!/usr/bin/env bash
set -euo pipefail

notify() {
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "Screenshot saved" "$1"
  fi
}

dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"

file="$dir/full-$(date +%Y-%m-%d_%H-%M-%S).png"
grim "$file"
wl-copy < "$file"
notify "$file"

