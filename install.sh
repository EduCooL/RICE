#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURRENT_DIR="$(pwd -P)"

info() {
  printf '[INFO] %s\n' "$1"
}

fail() {
  printf '[ERROR] %s\n' "$1" >&2
  exit 1
}

printf '\nPersonal Arch Hyprland Dotfiles bootstrap\n'
printf '=========================================\n\n'

[[ "$CURRENT_DIR" == "$REPO_ROOT" ]] || fail "Run this script from the repository root: $REPO_ROOT"

[[ -f "$REPO_ROOT/AGENTS.md" ]] || fail "AGENTS.md was not found. Run this script from the repository root."
[[ -d "$REPO_ROOT/packages" ]] || fail "packages/ was not found. Run this script from the repository root."
[[ -d "$REPO_ROOT/scripts" ]] || fail "scripts/ was not found. Run this script from the repository root."
[[ -d "$REPO_ROOT/stow" ]] || fail "stow/ was not found. Run this script from the repository root."

if ! command -v stow >/dev/null 2>&1; then
  printf '[WARN] GNU Stow is not installed.\n'
  printf '       Install packages first with: ./scripts/install-packages.sh\n'
  printf '       Or manually install stow: sudo pacman -S --needed stow\n\n'
  exit 1
fi

info "This script does not install packages automatically."
info "To install base packages, run: ./scripts/install-packages.sh"
printf '\n'

"$REPO_ROOT/scripts/backup-existing-configs.sh"
"$REPO_ROOT/scripts/stow-all.sh"
"$REPO_ROOT/scripts/check-health.sh"

printf '\nBootstrap complete.\n'
printf 'Next step: add the modular Hyprland MVP config and core scripts.\n'
