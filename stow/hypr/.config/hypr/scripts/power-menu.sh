#!/usr/bin/env bash
set -euo pipefail

confirm() {
  local action="$1"
  local answer

  answer="$(printf 'No\nYes\n' | rofi -dmenu -i -p "$action?" || true)"
  [[ "$answer" == "Yes" ]]
}

choice="$(printf 'Lock\nLogout\nSuspend\nReboot\nShutdown\n' | rofi -dmenu -i -p "Power" || true)"

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

