# Dotfiles Maintenance

## Apply On A Fresh Install

From the repository root:

```bash
./scripts/install-packages.sh
./scripts/backup-existing-configs.sh
./scripts/stow-all.sh
./scripts/check-health.sh
hyprctl reload
```

`backup-existing-configs.sh` moves known config conflicts into:

```text
~/.dotfiles-backups/YYYY-MM-DD_HH-MM-SS/
```

It does not delete user files.

## Update From GitHub

Default safe update:

```bash
./scripts/dotpull.sh
```

If local changes exist, the script refuses to pull. Inspect them:

```bash
./scripts/dotstatus.sh
```

## Pull Blocked By Local Changes

Git may print:

```text
error: Your local changes would be overwritten by merge
```

Use one of these options:

1. Commit local changes:

```bash
git add <files>
git commit -m "Describe local changes"
./scripts/dotpull.sh
```

2. Stash local changes and reapply after pull:

```bash
./scripts/dotpull.sh --stash
```

3. Discard local changes manually only after review:

```bash
git status --short
git restore <file>
```

Do not use `git reset --hard` unless you intentionally want to discard all local work.

## Stow Conflicts

If Stow reports conflicts:

```bash
./scripts/backup-existing-configs.sh
./scripts/stow-all.sh
```

If a single module is affected:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" hypr
```

Replace `hypr` with the module name.

## Missing Hypr Scripts

If `~/.config/hypr/scripts/*.sh` is missing after pulling:

```bash
stow --restow --dir="$PWD/stow" --target="$HOME" hypr
chmod +x ~/.config/hypr/scripts/*.sh
hyprctl reload
```

