#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
use_stash=0

usage() {
  printf 'usage: %s [--stash]\n' "$(basename "$0")"
  printf '  default: refuse to pull when local changes exist\n'
  printf '  --stash: stash local changes before pull and reapply after\n'
}

for arg in "$@"; do
  case "$arg" in
    --stash) use_stash=1 ;;
    -h|--help) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
  esac
done

cd "$REPO_ROOT"

if [[ -n "$(git status --porcelain)" && "$use_stash" -eq 0 ]]; then
  printf '[WARN] Local changes exist. Refusing to pull.\n' >&2
  printf 'Options:\n' >&2
  printf '  1. Review with: ./scripts/dotstatus.sh\n' >&2
  printf '  2. Commit your changes, then rerun dotpull.\n' >&2
  printf '  3. Stash safely with: ./scripts/dotpull.sh --stash\n' >&2
  printf '  4. Discard manually only if you are sure.\n' >&2
  exit 1
fi

stashed=0
if [[ "$use_stash" -eq 1 && -n "$(git status --porcelain)" ]]; then
  git stash push -u -m "dotpull $(date +%Y-%m-%d_%H-%M-%S)"
  stashed=1
fi

git pull --ff-only

if [[ "$stashed" -eq 1 ]]; then
  printf '[INFO] Reapplying stashed local changes.\n'
  git stash pop
fi

./scripts/stow-all.sh
./scripts/check-health.sh

