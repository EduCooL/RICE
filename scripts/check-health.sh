#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HYPR_SOURCE="$REPO_ROOT/stow/hypr/.config/hypr"
HYPR_CONFIG_HOME="$HOME/.config/hypr"
HYPR_CONFIG="$HYPR_CONFIG_HOME"

if [[ ! -f "$HYPR_CONFIG_HOME/hyprland.conf" && -d "$HYPR_SOURCE" ]]; then
  HYPR_CONFIG="$HYPR_SOURCE"
fi

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

check_file() {
  local path="$1"

  if [[ -f "$path" ]]; then
    ok "file exists: $path"
  else
    warn "file missing: $path"
  fi
}

check_executable() {
  local path="$1"

  if [[ -x "$path" ]]; then
    ok "script executable: $path"
  elif [[ -f "$path" ]]; then
    warn "script exists but is not executable: $path"
  else
    warn "script missing: $path"
  fi
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
check_command wl-paste wl-paste
check_command cliphist cliphist
check_command zsh zsh
check_command starship starship
check_command stow stow

printf '\nServices\n'
printf '%s\n' '--------'

check_system_service NetworkManager
check_system_service bluetooth
check_user_service pipewire
check_user_service wireplumber

printf '\nHyprland config\n'
printf '%s\n' '---------------'

if [[ "$HYPR_CONFIG" == "$HYPR_SOURCE" ]]; then
  warn "Hyprland module is not stowed to $HYPR_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --dir=\"\$PWD/stow\" --target=\"\$HOME\" hypr"
fi

check_file "$HYPR_CONFIG/hyprland.conf"
check_file "$HYPR_CONFIG/hyprlock.conf"
check_file "$HYPR_CONFIG/hyprpaper.conf"
check_file "$HYPR_CONFIG/conf/env.conf"
check_file "$HYPR_CONFIG/conf/monitors.conf"
check_file "$HYPR_CONFIG/conf/input.conf"
check_file "$HYPR_CONFIG/conf/decoration.conf"
check_file "$HYPR_CONFIG/conf/animations.conf"
check_file "$HYPR_CONFIG/conf/gestures.conf"
check_file "$HYPR_CONFIG/conf/workspaces.conf"
check_file "$HYPR_CONFIG/conf/windowrules.conf"
check_file "$HYPR_CONFIG/conf/keybinds.conf"
check_file "$HYPR_CONFIG/conf/autostart.conf"

printf '\nHyprland helper scripts\n'
printf '%s\n' '-----------------------'

check_executable "$HYPR_CONFIG/scripts/screenshot-area.sh"
check_executable "$HYPR_CONFIG/scripts/screenshot-full.sh"
check_executable "$HYPR_CONFIG/scripts/clipboard-menu.sh"
check_executable "$HYPR_CONFIG/scripts/power-menu.sh"
check_executable "$HYPR_CONFIG/scripts/launcher.sh"
check_executable "$HYPR_CONFIG/scripts/reload.sh"
check_executable "$HYPR_CONFIG/scripts/toggle-night-mode.sh"
check_executable "$HYPR_CONFIG/scripts/wallpaper.sh"

printf '\nHealth check finished. Warnings are expected before package installation.\n'
exit 0
