#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_ROOT="$HOME/.dotfiles-backups/$(date +%Y-%m-%d_%H-%M-%S)"

targets=(
  "$HOME/.config/hypr"
  "$HOME/.config/waybar"
  "$HOME/.config/quickshell"
  "$HOME/.config/rofi"
  "$HOME/.config/swaync"
  "$HOME/.config/kitty"
  "$HOME/.config/starship.toml"
  "$HOME/.zshrc"
  "$HOME/.gitconfig"
  "$HOME/.config/gtk-3.0"
  "$HOME/.config/gtk-4.0"
  "$HOME/.config/qt5ct"
  "$HOME/.config/qt6ct"
  "$HOME/.config/Kvantum"
  "$HOME/.config/user-dirs.dirs"
  "$HOME/.config/mimeapps.list"
  "$HOME/.config/Thunar"
  "$HOME/.config/yazi"
  "$HOME/.config/nvim"
)

moved=0

is_repo_symlink() {
  local path="$1"
  local resolved

  [[ -L "$path" ]] || return 1

  resolved="$(realpath -m "$path")"
  [[ "$resolved" == "$REPO_ROOT"* ]]
}

backup_target() {
  local target="$1"
  local relative backup_path

  [[ -e "$target" || -L "$target" ]] || return 0

  if is_repo_symlink "$target"; then
    printf '[OK] Already managed by this repo: %s\n' "$target"
    return 0
  fi

  relative="${target#"$HOME"/}"
  backup_path="$BACKUP_ROOT/$relative"

  mkdir -p "$(dirname "$backup_path")"
  mv "$target" "$backup_path"
  printf '[BACKUP] %s -> %s\n' "$target" "$backup_path"
  moved=1
}

for target in "${targets[@]}"; do
  backup_target "$target"
done

if (( moved == 0 )); then
  printf '[OK] No existing config conflicts found. No backup needed.\n'
else
  printf '[OK] Backups stored in: %s\n' "$BACKUP_ROOT"
fi
