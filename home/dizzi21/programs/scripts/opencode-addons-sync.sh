set -euo pipefail

base="${XDG_DATA_HOME:-$HOME/.local/share}/opencode-addons"
cfg="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"

clone_or_update() {
  local repo_url="$1"
  local dest="$2"

  if [ -d "$dest/.git" ]; then
    git -C "$dest" pull --ff-only
  else
    mkdir -p "$(dirname "$dest")"
    git clone "$repo_url" "$dest"
  fi
}

link_file() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  ln -s "$src" "$dest"
}

link_dir() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"
  rm -rf "$dest"
  ln -s "$src" "$dest"
}

clone_or_update "https://github.com/alvinunreal/oh-my-opencode-slim.git" "$base/oh-my-opencode-slim"
clone_or_update "https://github.com/JuliusBrussee/caveman.git" "$base/caveman"
clone_or_update "https://github.com/DietrichGebert/ponytail.git" "$base/ponytail"

mkdir -p "$cfg/skills" "$cfg/plugins" "$cfg/commands"

for skill in simplify codemap clonedeps; do
  link_dir "$base/oh-my-opencode-slim/src/skills/$skill" "$cfg/skills/$skill"
done

link_dir "$base/caveman/skills/caveman" "$cfg/skills/caveman"
link_dir "$base/caveman/src/plugins/opencode" "$cfg/plugins/caveman"
link_file "$base/caveman/src/plugins/opencode/commands/caveman.md" "$cfg/commands/caveman.md"

link_file "$base/ponytail/.opencode/plugins/ponytail.mjs" "$cfg/plugins/ponytail.mjs"
for command in ponytail{,-help,-review,-audit,-debt,-gain}; do
  link_file "$base/ponytail/.opencode/command/$command.md" "$cfg/commands/$command.md"
done

printf 'OpenCode addons synced. Restart OpenCode.\n'
