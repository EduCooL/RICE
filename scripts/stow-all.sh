#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STOW_DIR="$REPO_ROOT/stow"

if ! command -v stow >/dev/null 2>&1; then
  printf '[ERROR] GNU Stow is not installed. Install it with: sudo pacman -S --needed stow\n' >&2
  exit 1
fi

[[ -d "$STOW_DIR" ]] || {
  printf '[ERROR] Missing stow directory: %s\n' "$STOW_DIR" >&2
  exit 1
}

shopt -s nullglob
modules=("$STOW_DIR"/*)

if (( ${#modules[@]} == 0 )); then
  printf '[WARN] No Stow modules found in %s\n' "$STOW_DIR"
  exit 0
fi

for module_path in "${modules[@]}"; do
  [[ -d "$module_path" ]] || continue
  module="$(basename "$module_path")"

  mapfile -t real_files < <(find "$module_path" -type f ! -name '.gitkeep')
  if (( ${#real_files[@]} == 0 )); then
    printf '[SKIP] %s has only placeholders\n' "$module"
    continue
  fi

  printf '[STOW] %s\n' "$module"
  stow --dir="$STOW_DIR" --target="$HOME" "$module"
done

printf '[OK] Stow complete.\n'
