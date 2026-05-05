#!/usr/bin/env bash
set -euo pipefail

notify() {
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "Screenshot saved" "$1"
  fi
}

dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"

region="$(slurp 2>/dev/null || true)"
if [[ -z "$region" ]]; then
  exit 0
fi

file="$dir/area-$(date +%Y-%m-%d_%H-%M-%S).png"
grim -g "$region" "$file"
wl-copy < "$file"
notify "$file"

