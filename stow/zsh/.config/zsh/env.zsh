# Environment kept small and quiet.

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export BROWSER="${BROWSER:-firefox}"
export TERMINAL="${TERMINAL:-kitty}"
export PAGER="${PAGER:-less}"

export LESS='-R --mouse --wheel-lines=3'
export LESSHISTFILE='-'

if command -v bat >/dev/null 2>&1; then
  export BAT_THEME="${BAT_THEME:-base16}"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
fi

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:-}"
FZF_DEFAULT_OPTS+=" --height=40% --layout=reverse --border=rounded"
FZF_DEFAULT_OPTS+=" --color=bg:#151A19,bg+:#1E2322,fg:#D8E1DC,fg+:#D8E1DC"
FZF_DEFAULT_OPTS+=" --color=hl:#6E8D88,hl+:#A7B9B1,info:#B89A6A,prompt:#8BAE8B,pointer:#B89A6A,marker:#6E8D88"
export FZF_DEFAULT_OPTS

path_prepend() {
  [[ -d "$1" ]] || return
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1:$PATH" ;;
  esac
}

path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/go/bin"
export PATH

