#!/usr/bin/env bash
set -euo pipefail

ok() {
  printf '[OK]   %s\n' "$1"
}

warn() {
  printf '[WARN] %s\n' "$1"
}

check_command() {
  local cmd="$1"
  if command -v "$cmd" >/dev/null 2>&1; then
    ok "$cmd found"
  else
    warn "$cmd missing"
  fi
}

printf 'Developer tooling health\n'
printf '%s\n' '------------------------'

for cmd in git gh ssh ssh-agent docker docker-compose psql pg_isready python node npm pnpm nvim yazi tmux; do
  check_command "$cmd"
done

if command -v docker >/dev/null 2>&1; then
  if docker info >/dev/null 2>&1; then
    ok "Docker daemon reachable by current user"
  else
    warn "Docker command exists, but daemon is not reachable. Check service status or user group membership."
  fi
fi

if command -v pg_isready >/dev/null 2>&1; then
  if pg_isready -h localhost -p 5432 >/dev/null 2>&1; then
    ok "PostgreSQL appears reachable on localhost:5432"
  else
    warn "No PostgreSQL response on localhost:5432"
  fi
fi

printf '\nThis script reports development tooling only. It does not modify services or install packages.\n'

