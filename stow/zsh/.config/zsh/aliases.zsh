# Aliases are conditional so fresh installs do not get noisy shells.

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons=auto --group-directories-first'
  alias ll='eza -la --icons=auto --group-directories-first'
  alias la='eza -a --icons=auto --group-directories-first'
  alias lt='eza --tree --level=2 --icons=auto'
else
  alias ll='ls -lah'
  alias la='ls -A'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
fi

if command -v rg >/dev/null 2>&1; then
  alias grep='rg'
fi

if command -v fd >/dev/null 2>&1; then
  alias find='fd'
fi

alias v='nvim'
alias c='clear'
alias q='exit'

alias g='git'
alias gs='git status --short'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

alias dots='cd "$DOTFILES_DIR"'
alias dotfiles='cd "$DOTFILES_DIR"'
alias hreload='hyprctl reload'
alias rice-health='"$DOTFILES_DIR/scripts/check-health.sh"'

if command -v yazi >/dev/null 2>&1; then
  alias yz='yazi'
fi

if command -v tmux >/dev/null 2>&1; then
  alias ta='tmux attach'
  alias tl='tmux list-sessions'
  alias tn='tmux new -s'
fi

if command -v fastfetch >/dev/null 2>&1; then
  alias ff='fastfetch'
fi

