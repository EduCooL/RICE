#!/usr/bin/env bash
set -euo pipefail

ok() {
  printf '[OK]   %s\n' "$1"
}

warn() {
  printf '[WARN] %s\n' "$1"
}

check_command() {
  local label="$1"
  shift

  for cmd in "$@"; do
    if command -v "$cmd" >/dev/null 2>&1; then
      ok "$label command found: $cmd"
      return 0
    fi
  done

  warn "$label command missing: $*"
}

check_system_service() {
  local service="$1"

  if ! command -v systemctl >/dev/null 2>&1; then
    warn "systemctl not found; cannot check $service"
    return 0
  fi

  if systemctl is-active --quiet "$service" 2>/dev/null; then
    ok "$service system service is active"
  else
    warn "$service system service is not active or not installed"
  fi
}

check_user_service() {
  local service="$1"

  if ! command -v systemctl >/dev/null 2>&1; then
    warn "systemctl not found; cannot check user service $service"
    return 0
  fi

  if systemctl --user is-active --quiet "$service" 2>/dev/null; then
    ok "$service user service is active"
  else
    warn "$service user service is not active or not installed"
  fi
}

printf 'Dotfiles health check\n'
printf '=====================\n\n'

check_command hyprland hyprland Hyprland
check_command waybar waybar
check_command rofi rofi
check_command swaync swaync
check_command kitty kitty
check_command hyprpaper hyprpaper
check_command hyprlock hyprlock
check_command grim grim
check_command slurp slurp
check_command swappy swappy
check_command wl-copy wl-copy
check_command cliphist cliphist
check_command zsh zsh
check_command starship starship
check_command stow stow

printf '\nServices\n'
printf '--------\n'

check_system_service NetworkManager
check_system_service bluetooth
check_user_service pipewire
check_user_service wireplumber

printf '\nHealth check finished. Warnings are expected before package installation.\n'
exit 0

