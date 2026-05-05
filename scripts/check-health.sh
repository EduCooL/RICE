#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HYPR_SOURCE="$REPO_ROOT/stow/hypr/.config/hypr"
HYPR_CONFIG_HOME="$HOME/.config/hypr"
HYPR_CONFIG="$HYPR_CONFIG_HOME"
WAYBAR_SOURCE="$REPO_ROOT/stow/waybar/.config/waybar"
WAYBAR_CONFIG_HOME="$HOME/.config/waybar"
WAYBAR_CONFIG="$WAYBAR_CONFIG_HOME"
ROFI_SOURCE="$REPO_ROOT/stow/rofi/.config/rofi"
ROFI_CONFIG_HOME="$HOME/.config/rofi"
ROFI_CONFIG="$ROFI_CONFIG_HOME"
SWAYNC_SOURCE="$REPO_ROOT/stow/swaync/.config/swaync"
SWAYNC_CONFIG_HOME="$HOME/.config/swaync"
SWAYNC_CONFIG="$SWAYNC_CONFIG_HOME"
KITTY_SOURCE="$REPO_ROOT/stow/kitty/.config/kitty"
KITTY_CONFIG_HOME="$HOME/.config/kitty"
KITTY_CONFIG="$KITTY_CONFIG_HOME"
ZSH_SOURCE="$REPO_ROOT/stow/zsh"
ZSH_CONFIG_HOME="$HOME"
ZSH_CONFIG="$ZSH_CONFIG_HOME"
STARSHIP_SOURCE="$REPO_ROOT/stow/starship/.config"
STARSHIP_CONFIG_HOME="$HOME/.config"
STARSHIP_CONFIG="$STARSHIP_CONFIG_HOME"
GTK_SOURCE="$REPO_ROOT/stow/gtk/.config"
GTK_CONFIG_HOME="$HOME/.config"
GTK_CONFIG="$GTK_CONFIG_HOME"
QT_SOURCE="$REPO_ROOT/stow/qt/.config"
QT_CONFIG_HOME="$HOME/.config"
QT_CONFIG="$QT_CONFIG_HOME"
XDG_SOURCE="$REPO_ROOT/stow/xdg/.config"
XDG_CONFIG_HOME="$HOME/.config"
XDG_CONFIG="$XDG_CONFIG_HOME"
THUNAR_SOURCE="$REPO_ROOT/stow/thunar/.config/Thunar"
THUNAR_CONFIG_HOME="$HOME/.config/Thunar"
THUNAR_CONFIG="$THUNAR_CONFIG_HOME"

if [[ ! -f "$HYPR_CONFIG_HOME/hyprland.conf" && -d "$HYPR_SOURCE" ]]; then
  HYPR_CONFIG="$HYPR_SOURCE"
fi

if [[ ! -f "$WAYBAR_CONFIG_HOME/config.jsonc" && -d "$WAYBAR_SOURCE" ]]; then
  WAYBAR_CONFIG="$WAYBAR_SOURCE"
fi

if [[ ! -f "$ROFI_CONFIG_HOME/config.rasi" && -d "$ROFI_SOURCE" ]]; then
  ROFI_CONFIG="$ROFI_SOURCE"
fi

if [[ ! -f "$SWAYNC_CONFIG_HOME/config.json" && -d "$SWAYNC_SOURCE" ]]; then
  SWAYNC_CONFIG="$SWAYNC_SOURCE"
fi

if [[ ! -f "$KITTY_CONFIG_HOME/kitty.conf" && -d "$KITTY_SOURCE" ]]; then
  KITTY_CONFIG="$KITTY_SOURCE"
fi

if [[ ! -f "$ZSH_CONFIG_HOME/.zshrc" && -d "$ZSH_SOURCE" ]]; then
  ZSH_CONFIG="$ZSH_SOURCE"
fi

if [[ ! -f "$STARSHIP_CONFIG_HOME/starship.toml" && -d "$STARSHIP_SOURCE" ]]; then
  STARSHIP_CONFIG="$STARSHIP_SOURCE"
fi

if [[ ! -f "$GTK_CONFIG_HOME/gtk-3.0/settings.ini" && -d "$GTK_SOURCE" ]]; then
  GTK_CONFIG="$GTK_SOURCE"
fi

if [[ ! -f "$QT_CONFIG_HOME/qt6ct/qt6ct.conf" && -d "$QT_SOURCE" ]]; then
  QT_CONFIG="$QT_SOURCE"
fi

if [[ ! -f "$XDG_CONFIG_HOME/user-dirs.dirs" && -d "$XDG_SOURCE" ]]; then
  XDG_CONFIG="$XDG_SOURCE"
fi

if [[ ! -f "$THUNAR_CONFIG_HOME/uca.xml" && -d "$THUNAR_SOURCE" ]]; then
  THUNAR_CONFIG="$THUNAR_SOURCE"
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

check_dir() {
  local path="$1"

  if [[ -d "$path" ]]; then
    ok "directory exists: $path"
  else
    warn "directory missing: $path"
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
check_command swaync-client swaync-client
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
check_command eza eza
check_command bat bat
check_command rg rg
check_command fd fd
check_command fzf fzf
check_command zoxide zoxide
check_command yazi yazi
check_command tmux tmux
check_command gh gh
check_command ssh ssh
check_command docker docker
check_command docker-compose docker-compose
check_command nwg-look nwg-look
check_command qt5ct qt5ct
check_command qt6ct qt6ct
check_command kvantummanager kvantummanager
check_command thunar thunar
check_command xdg-user-dirs-update xdg-user-dirs-update
check_command xdg-open xdg-open

printf '\nServices\n'
printf '%s\n' '--------'

check_system_service NetworkManager
check_system_service bluetooth
check_user_service pipewire
check_user_service wireplumber

printf '\nRepository structure\n'
printf '%s\n' '--------------------'

check_dir "$REPO_ROOT/packages"
check_dir "$REPO_ROOT/scripts"
check_dir "$REPO_ROOT/stow"
check_dir "$REPO_ROOT/themes"
check_dir "$REPO_ROOT/wallpapers"
check_dir "$REPO_ROOT/docs"
check_file "$REPO_ROOT/AGENTS.md"
check_file "$REPO_ROOT/README.md"
check_file "$REPO_ROOT/install.sh"

printf '\nPackage manifests\n'
printf '%s\n' '-----------------'

check_file "$REPO_ROOT/packages/pacman.txt"
check_file "$REPO_ROOT/packages/aur.txt"
check_file "$REPO_ROOT/packages/flatpak.txt"
check_file "$REPO_ROOT/packages/optional.txt"

printf '\nTheme files\n'
printf '%s\n' '-----------'

check_file "$REPO_ROOT/themes/colors.json"
check_file "$REPO_ROOT/themes/colors.conf"
check_file "$REPO_ROOT/themes/colors.css"
check_file "$REPO_ROOT/themes/colors.rasi"
check_file "$REPO_ROOT/themes/colors.sh"
check_file "$REPO_ROOT/themes/colors.qml"
check_file "$ROFI_CONFIG/themes/shared.rasi"
check_file "$WAYBAR_CONFIG/style.css"
check_file "$SWAYNC_CONFIG/style.css"
check_file "$KITTY_CONFIG/theme.conf"
check_file "$HYPR_CONFIG/hyprlock.conf"

printf '\nRepository scripts\n'
printf '%s\n' '------------------'

check_executable "$REPO_ROOT/install.sh"
check_executable "$REPO_ROOT/scripts/install-packages.sh"
check_executable "$REPO_ROOT/scripts/backup-existing-configs.sh"
check_executable "$REPO_ROOT/scripts/stow-all.sh"
check_executable "$REPO_ROOT/scripts/apply-theme.sh"
check_executable "$REPO_ROOT/scripts/check-health.sh"
check_executable "$REPO_ROOT/scripts/dotpull.sh"
check_executable "$REPO_ROOT/scripts/dotstatus.sh"
check_executable "$REPO_ROOT/scripts/dev-health.sh"

printf '\nDocumentation\n'
printf '%s\n' '-------------'

check_file "$REPO_ROOT/docs/DEV_WORKFLOW.md"
check_file "$REPO_ROOT/docs/DOTFILES_MAINTENANCE.md"
check_file "$REPO_ROOT/docs/DOCKER_POSTGRES.md"
check_file "$REPO_ROOT/docs/SSH_GITHUB.md"
check_file "$REPO_ROOT/wallpapers/README.md"

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
check_executable "$HYPR_CONFIG/scripts/window-menu.sh"
check_executable "$HYPR_CONFIG/scripts/notification-center.sh"
check_executable "$HYPR_CONFIG/scripts/reload.sh"
check_executable "$HYPR_CONFIG/scripts/toggle-night-mode.sh"
check_executable "$HYPR_CONFIG/scripts/wallpaper.sh"

printf '\nWallpaper and lockscreen\n'
printf '%s\n' '------------------------'

if [[ -e "$HOME/Pictures/Wallpapers/current" ]]; then
  ok "wallpaper convention exists: $HOME/Pictures/Wallpapers/current"
else
  warn "wallpaper missing: create ~/Pictures/Wallpapers/current or run wallpapers/README.md setup"
fi

check_file "$HYPR_CONFIG/hyprlock.conf"
check_file "$HYPR_CONFIG/hyprpaper.conf"

printf '\nWaybar config\n'
printf '%s\n' '-------------'

if [[ "$WAYBAR_CONFIG" == "$WAYBAR_SOURCE" ]]; then
  warn "Waybar module is not stowed to $WAYBAR_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" waybar"
fi

check_file "$WAYBAR_CONFIG/config.jsonc"
check_file "$WAYBAR_CONFIG/style.css"
check_file "$WAYBAR_CONFIG/README.md"

printf '\nWaybar module scripts\n'
printf '%s\n' '---------------------'

check_executable "$WAYBAR_CONFIG/modules/power.sh"
check_executable "$WAYBAR_CONFIG/modules/clipboard.sh"
check_executable "$WAYBAR_CONFIG/modules/network.sh"
check_executable "$WAYBAR_CONFIG/modules/updates.sh"

printf '\nRofi config\n'
printf '%s\n' '-----------'

if [[ "$ROFI_CONFIG" == "$ROFI_SOURCE" ]]; then
  warn "Rofi module is not stowed to $ROFI_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" rofi hypr"
fi

check_file "$ROFI_CONFIG/config.rasi"
check_file "$ROFI_CONFIG/themes/shared.rasi"
check_file "$ROFI_CONFIG/themes/launcher.rasi"
check_file "$ROFI_CONFIG/themes/power-menu.rasi"
check_file "$ROFI_CONFIG/themes/clipboard.rasi"
check_file "$ROFI_CONFIG/themes/window.rasi"
check_file "$ROFI_CONFIG/README.md"

printf '\nSwayNC config\n'
printf '%s\n' '-------------'

if [[ "$SWAYNC_CONFIG" == "$SWAYNC_SOURCE" ]]; then
  warn "SwayNC module is not stowed to $SWAYNC_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" swaync hypr"
fi

check_file "$SWAYNC_CONFIG/config.json"
check_file "$SWAYNC_CONFIG/style.css"
check_file "$SWAYNC_CONFIG/README.md"

printf '\nTerminal and shell config\n'
printf '%s\n' '-------------------------'

if [[ "$KITTY_CONFIG" == "$KITTY_SOURCE" ]]; then
  warn "Kitty module is not stowed to $KITTY_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" kitty"
fi

if [[ "$ZSH_CONFIG" == "$ZSH_SOURCE" ]]; then
  warn "Zsh module is not stowed to $ZSH_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" zsh"
fi

if [[ "$STARSHIP_CONFIG" == "$STARSHIP_SOURCE" ]]; then
  warn "Starship module is not stowed to $STARSHIP_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" starship"
fi

check_file "$KITTY_CONFIG/kitty.conf"
check_file "$KITTY_CONFIG/theme.conf"
check_file "$KITTY_CONFIG/README.md"
check_file "$ZSH_CONFIG/.zshrc"
check_file "$ZSH_CONFIG/.config/zsh/env.zsh"
check_file "$ZSH_CONFIG/.config/zsh/aliases.zsh"
check_file "$ZSH_CONFIG/.config/zsh/functions.zsh"
check_file "$ZSH_CONFIG/README.md"
check_file "$STARSHIP_CONFIG/starship.toml"

printf '\nGTK, Qt, XDG, and file manager config\n'
printf '%s\n' '--------------------------------------'

if [[ "$GTK_CONFIG" == "$GTK_SOURCE" ]]; then
  warn "GTK module is not stowed to $GTK_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" gtk"
fi

if [[ "$QT_CONFIG" == "$QT_SOURCE" ]]; then
  warn "Qt module is not stowed to $QT_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" qt"
fi

if [[ "$XDG_CONFIG" == "$XDG_SOURCE" ]]; then
  warn "XDG module is not stowed to $XDG_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" xdg"
fi

if [[ "$THUNAR_CONFIG" == "$THUNAR_SOURCE" ]]; then
  warn "Thunar module is not stowed to $THUNAR_CONFIG_HOME; checking repository source files instead"
  warn "Run: stow --restow --dir=\"\$PWD/stow\" --target=\"\$HOME\" thunar"
fi

check_file "$GTK_CONFIG/gtk-3.0/settings.ini"
check_file "$GTK_CONFIG/gtk-3.0/gtk.css"
check_file "$GTK_CONFIG/gtk-4.0/settings.ini"
check_file "$GTK_CONFIG/gtk-4.0/gtk.css"
check_file "$QT_CONFIG/qt5ct/qt5ct.conf"
check_file "$QT_CONFIG/qt6ct/qt6ct.conf"
check_file "$QT_CONFIG/Kvantum/kvantum.kvconfig"
check_file "$QT_CONFIG/Kvantum/CozyRain/CozyRain.kvconfig"
check_file "$QT_CONFIG/Kvantum/CozyRain/CozyRain.svg"
check_file "$XDG_CONFIG/user-dirs.dirs"
check_file "$XDG_CONFIG/mimeapps.list"
check_file "$XDG_CONFIG/README.md"
check_file "$THUNAR_CONFIG/uca.xml"

printf '\nNext actions\n'
printf '%s\n' '------------'
printf '1. Fix WARN items that apply to this machine.\n'
printf '2. If configs were just pulled, run: ./scripts/stow-all.sh\n'
printf '3. Reload Hyprland with: hyprctl reload\n'
printf '4. Test wallpaper with: ~/.config/hypr/scripts/wallpaper.sh\n'

printf '\nHealth check finished. Warnings are expected before package installation.\n'
exit 0
