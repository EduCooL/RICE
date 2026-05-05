#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$REPO_ROOT"

printf 'Dotfiles status\n'
printf '%s\n' '---------------'
git status --short --branch

printf '\nChanged files by module\n'
printf '%s\n' '-----------------------'
git status --short | awk '
  {
    path=$2
    if ($1 ~ /^R/) path=$4
    split(path, parts, "/")
    if (parts[1] == "stow") {
      print "stow/" parts[2]
    } else if (parts[1] != "") {
      print parts[1]
    }
  }
' | sort -u

