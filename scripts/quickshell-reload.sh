#!/usr/bin/env bash
set -euo pipefail

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
SCRIPT="$CONFIG_HOME/quickshell/scripts/reload-quickshell.sh"

if [[ -x "$SCRIPT" ]]; then
  "$SCRIPT"
else
  printf 'Quickshell reload helper is not stowed yet: %s\n' "$SCRIPT" >&2
  printf 'Run: stow --restow --dir="$PWD/stow" --target="$HOME" quickshell\n' >&2
  exit 1
fi
