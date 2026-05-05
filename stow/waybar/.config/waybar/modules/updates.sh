#!/usr/bin/env bash
set -euo pipefail

if ! command -v checkupdates >/dev/null 2>&1; then
  printf '{"text":"","tooltip":"Install pacman-contrib for update checks","class":"neutral"}\n'
  exit 0
fi

count="$(checkupdates 2>/dev/null | wc -l | tr -d ' ')"

if [[ "$count" == "0" ]]; then
  printf '{"text":"","tooltip":"System packages are up to date","class":"clean"}\n'
else
  printf '{"text":"up %s","tooltip":"%s pacman updates available","class":"updates"}\n' "$count" "$count"
fi
