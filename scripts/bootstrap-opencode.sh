#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
config_dir=${XDG_CONFIG_HOME:-$HOME/.config}/opencode
skills_dir=$config_dir/skills
mode=${1:-install}
skills=(code-review codebase-design diagnosing-bugs domain-modeling grill-with-docs grilling handoff improve-codebase-architecture research resolving-merge-conflicts tdd)

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
  mkdir -p "$config_dir" "$skills_dir"
fi

link "$repo_dir/opencode/AGENTS.md" "$config_dir/AGENTS.md"
for skill in "${skills[@]}"; do
  link "$repo_dir/opencode/skills/$skill" "$skills_dir/$skill"
done

printf 'OpenCode bootstrap %s complete.\n' "$mode"
