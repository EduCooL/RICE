#!/usr/bin/env bash
set -euo pipefail

theme="$HOME/.config/rofi/themes/power-menu.rasi"

if ! command -v rofi >/dev/null 2>&1; then
  printf 'rofi is not installed. Install rofi-wayland.\n' >&2
  exit 1
fi

confirm() {
  local action="$1"
  local answer

  answer="$(printf 'No\nYes\n' | rofi -dmenu -i -p "$action?" -theme "$theme" || true)"
  [[ "$answer" == "Yes" ]]
}

choice="$(printf 'Lock\nLogout\nSuspend\nReboot\nShutdown\n' | rofi -dmenu -i -p "power" -theme "$theme" || true)"

case "$choice" in
  Lock)
    hyprlock
    ;;
  Logout)
    hyprctl dispatch exit
    ;;
  Suspend)
    systemctl suspend
    ;;
  Reboot)
    if confirm "Reboot"; then
      systemctl reboot
    fi
    ;;
  Shutdown)
    if confirm "Shutdown"; then
      systemctl poweroff
    fi
    ;;
  *)
    exit 0
    ;;
esac
