# Fast, minimal Zsh foundation for daily development.

export ZDOTDIR="${ZDOTDIR:-$HOME}"
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

zsh_config_dir="$HOME/.config/zsh"

for file in env aliases functions; do
  if [[ -r "$zsh_config_dir/$file.zsh" ]]; then
    source "$zsh_config_dir/$file.zsh"
  fi
done

HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=50000
SAVEHIST=50000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP

bindkey -e

autoload -Uz compinit
comp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${comp_cache:h}"
compinit -i -d "$comp_cache"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

if command -v fzf >/dev/null 2>&1; then
  if [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
  fi
  if [[ -r /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
  fi
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  PROMPT='%F{green}%~%f %# '
fi
