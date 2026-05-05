#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACMAN_FILE="$REPO_ROOT/packages/pacman.txt"

[[ -f "$PACMAN_FILE" ]] || {
  printf '[ERROR] Missing package list: %s\n' "$PACMAN_FILE" >&2
  exit 1
}

mapfile -t packages < <(grep -vE '^[[:space:]]*(#|$)' "$PACMAN_FILE")

if (( ${#packages[@]} == 0 )); then
  printf '[WARN] No Pacman packages found in %s\n' "$PACMAN_FILE"
  exit 0
fi

printf 'Pacman packages to install:\n\n'
printf '  %s\n' "${packages[@]}"
printf '\n'

read -r -p 'Install these packages with sudo pacman -S --needed? [y/N] ' answer
case "$answer" in
  [yY]|[yY][eE][sS])
    sudo pacman -S --needed "${packages[@]}"
    ;;
  *)
    printf 'Skipped Pacman package installation.\n'
    ;;
esac

printf '\nAUR packages are optional and are not installed automatically.\n'
printf 'Review: %s\n' "$REPO_ROOT/packages/aur.txt"
printf 'Example with paru: paru -S --needed $(grep -vE '"'"'^[[:space:]]*(#|$)'"'"' packages/aur.txt)\n'

printf '\nFlatpak packages are optional and are not installed automatically.\n'
printf 'Review: %s\n' "$REPO_ROOT/packages/flatpak.txt"
printf 'Example: flatpak install flathub <app-id>\n'
