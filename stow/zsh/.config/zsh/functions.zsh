# Small practical functions. No destructive shortcuts.

mkcd() {
  if [[ $# -ne 1 ]]; then
    printf 'usage: mkcd <dir>\n' >&2
    return 2
  fi
  mkdir -p -- "$1" && cd -- "$1"
}

take() {
  mkcd "$@"
}

extract() {
  if [[ $# -ne 1 ]]; then
    printf 'usage: extract <archive>\n' >&2
    return 2
  fi

  local archive="$1"
  if [[ ! -f "$archive" ]]; then
    printf 'extract: not a file: %s\n' "$archive" >&2
    return 1
  fi

  case "$archive" in
    *.tar.bz2|*.tbz2) tar xjf "$archive" ;;
    *.tar.gz|*.tgz) tar xzf "$archive" ;;
    *.tar.xz|*.txz) tar xJf "$archive" ;;
    *.tar) tar xf "$archive" ;;
    *.zip) unzip "$archive" ;;
    *.7z) 7z x "$archive" ;;
    *.rar) unrar x "$archive" ;;
    *.gz) gunzip "$archive" ;;
    *.bz2) bunzip2 "$archive" ;;
    *.xz) unxz "$archive" ;;
    *) printf 'extract: unsupported archive: %s\n' "$archive" >&2; return 1 ;;
  esac
}

dotpull() {
  local dir="${DOTFILES_DIR:-$HOME/dotfiles}"
  if [[ ! -d "$dir/.git" ]]; then
    printf 'dotpull: not a git repo: %s\n' "$dir" >&2
    return 1
  fi

  (
    cd "$dir" || exit 1
    git pull
    ./scripts/stow-all.sh
    ./scripts/check-health.sh
  )
}

weather() {
  printf 'weather: placeholder. Add a local provider later if needed.\n'
}

