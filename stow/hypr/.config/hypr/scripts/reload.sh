#!/usr/bin/env bash
set -euo pipefail

notify() {
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "Hyprland" "$1"
  fi
}

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload
fi

if command -v waybar >/dev/null 2>&1; then
  pkill -x waybar 2>/dev/null || true
  waybar >/dev/null 2>&1 &
fi

if command -v swaync-client >/dev/null 2>&1; then
  swaync-client --reload-config >/dev/null 2>&1 || true
  swaync-client --reload-css >/dev/null 2>&1 || true
fi

notify "Configuration reloaded"

