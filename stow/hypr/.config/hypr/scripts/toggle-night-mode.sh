#!/usr/bin/env bash
set -euo pipefail

printf 'Night mode toggle is not implemented yet.\n'
printf 'Future behavior: toggle a warm evening color temperature with wlsunset or gammastep when one is selected for this rice.\n'

if command -v notify-send >/dev/null 2>&1; then
  notify-send "Night mode" "Not implemented yet"
fi

