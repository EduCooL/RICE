#!/usr/bin/env bash
set -euo pipefail

if ! command -v quickshell >/dev/null 2>&1; then
  printf 'quickshell is not installed. Install it with: sudo pacman -S quickshell\n' >&2
  exit 1
fi

pkill quickshell 2>/dev/null || true
quickshell &
printf '%s\n' 'Quickshell restarted.'
