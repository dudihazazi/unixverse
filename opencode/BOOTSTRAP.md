# OpenCode external dependency bootstrap

This repository owns the global guidance and custom skills wired by
`scripts/bootstrap-opencode.sh`. Do not add third-party clones or network
operations to that script.

Before installing or updating anything external, inspect the current official
upstream installation documentation. Do not rely on remembered commands or
hard-coded repository layouts. Verify the instructions and compatibility with
the installed OpenCode version first.

Desired sources/categories:

- OMO-slim (oh-my-opencode-slim) plugin:
  <https://github.com/alvinunreal/oh-my-opencode-slim>
- Caveman plugin: <https://github.com/JuliusBrussee/caveman>
- Third-party skills: <https://github.com/mattpocock/skills>

These URLs are starting points, not pinned installation commands. Check the
current upstream documentation, repository layout, release notes, and OpenCode
compatibility before installing or updating them.

Install only the plugins and skills actually requested, using the
upstream-supported method. Preserve existing user data, configuration, and
unrelated plugins. Never replace non-symlink files belonging to the user.

The Nix-managed global config is read-only. Put machine-local MCP and plugin
settings in `${XDG_CONFIG_HOME:-$HOME/.config}/opencode/opencode.local.json`.
The installed `opencode` wrapper loads that overlay after the global config.
For Pencil, first verify the current Pencil MCP executable and the current
OpenCode MCP schema; then add a local `mcp.pencil` entry using the verified
path. Do not commit that file or its absolute path.

After external setup, validate that OpenCode detects the installed plugins and
skills (use the current upstream/OpenCode diagnostic or listing command), then
run from the repository:

```bash
bash scripts/bootstrap-opencode.sh install
bash scripts/bootstrap-opencode.sh check
```

The local script only links repository-managed `AGENTS.md` and custom skills.
It does not install, clone, update, or configure external dependencies.
