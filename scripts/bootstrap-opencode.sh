#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
config_dir=${XDG_CONFIG_HOME:-$HOME/.config}/opencode
mode=${1:-install}

die() { printf 'bootstrap-opencode: %s\n' "$*" >&2; exit 1; }

link() {
  local source=$1 target=$2
  [ -e "$source" ] || die "missing expected source: $source"
  if [ -L "$target" ]; then
    [ "$(readlink "$target")" = "$source" ] && [ -e "$target" ] && return
    [ "$mode" = check ] && die "incorrect or dangling symlink: $target"
    rm "$target"
  elif [ -e "$target" ]; then
    die "refusing to overwrite non-symlink: $target"
  elif [ "$mode" = check ]; then
    die "missing managed symlink: $target"
  fi
  [ "$mode" = check ] || ln -s "$source" "$target"
}

case "$mode" in
  install | check) ;;
  *) die "usage: $0 {install|check}" ;;
esac

if [ "$mode" = install ]; then
  mkdir -p "$config_dir"
fi

link "$repo_dir/opencode/AGENTS.md" "$config_dir/AGENTS.md"

printf 'OpenCode bootstrap %s complete.\n' "$mode"
