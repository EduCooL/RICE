# Zsh MVP

This module provides a fast shell foundation without Oh My Zsh or plugin managers.

Files:

- `.zshrc`: startup, history, completion, Starship, zoxide, fzf
- `.config/zsh/env.zsh`: environment and PATH
- `.config/zsh/aliases.zsh`: conditional aliases
- `.config/zsh/functions.zsh`: small helper functions

Apply:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" zsh starship
```

Switch shell:

```bash
chsh -s "$(command -v zsh)"
```

