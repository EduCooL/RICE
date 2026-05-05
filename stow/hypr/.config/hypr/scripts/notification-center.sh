#!/usr/bin/env bash
set -euo pipefail

if ! command -v swaync-client >/dev/null 2>&1; then
  printf 'swaync-client is not installed. Install swaync.\n' >&2
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "SwayNC" "swaync-client is not installed"
  fi
  exit 1
fi

swaync-client -t -sw

