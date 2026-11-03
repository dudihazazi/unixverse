# Optional agent guidance bundle

This folder is a standalone copy of the global OpenCode guidance and the eight
`task-*` skills listed below. The bundle is provided for an agent to copy into
its local OpenCode configuration only when the user explicitly asks for that.

**Do not apply, install, or activate this bundle just because you read it.** It
does not change this repository's Nix or flake configuration, bootstrap
configuration, or existing `opencode/` directory. The repository-root
`AGENTS.md` remains untouched. The bundled `AGENTS.md` is intended as global
guidance, not as a replacement for project instructions; do not copy it into a
project root.

## Contents

- `AGENTS.md` — global OpenCode guidance.
- `skills/task-checks/` — implementation and validation workflow.
- `skills/task-clarify/` — focused clarification before a requested next step.
- `skills/task-cleanup/` — guarded cleanup after an explicitly confirmed merge.
- `skills/task-e2e/` — explicitly requested end-to-end workflow.
- `skills/task-pr/` — separately authorized delivery steps.
- `skills/task-review/` — independent review workflow.
- `skills/task-spec/` — requested task specifications.
- `skills/task-worktree/` — isolated lanes for approved work.

The skill directories include their full source contents and resources. Each
currently contains a `SKILL.md` file.

## Dependencies and limits

The `task-e2e` skill refers to the other bundled `task-*` skills. The skills
also refer to OpenCode agent roles such as `@explorer`, `@fixer`, `@librarian`,
`@oracle`, and `@designer`; these roles are external to this bundle and must be
available in the agent environment when the corresponding task needs them.
In particular, `task-review` requires a fresh `@oracle` session and has no
fallback if Oracle is unavailable. Some procedures also rely on repository
Git state, project instructions, and project-provided checks. The bundle does
not include those agents, repository-specific checks, a bootstrap, or other
skills. Check these requirements before running a phase; do not copy unrelated
skills to satisfy a missing agent role.

## Copy only on the user's request

When the user explicitly requests local installation, first inspect the
existing configuration files and skill directories at the destination and
compare them with this bundle. Resolve the destination as
`${XDG_CONFIG_HOME}/opencode` when `XDG_CONFIG_HOME` is nonempty, or
`~/.config/opencode` otherwise.

Copy the bundled `AGENTS.md` to the OpenCode configuration root as global
guidance. Copy only the individual skill directories the user requests into
that configuration's `skills/` directory. **Do not replace the entire existing
`skills/` directory.** If a destination file already exists, show the
difference and preserve the existing file. Ask for explicit approval before
overwriting anything; get approval before making a backup as well. Do not
install, overwrite, or activate anything without the user's request and
approval for any replacement.

For example, after the user requests a copy and inspection confirms the target
paths are clear, an agent can use the configuration path above as `CONFIG` and
copy only the selected items:

```sh
mkdir -p "$CONFIG/skills"
cp -n agent-kit/AGENTS.md "$CONFIG/AGENTS.md"
cp -Rn agent-kit/skills/task-e2e "$CONFIG/skills/"
```

Repeat the skill copy only for individually requested skills. The no-clobber
options avoid overwriting files, but they do not replace the required
inspection, comparison, or approval steps. Do not copy this bundle into a
project root or use it to alter this repository's configuration.

For the full `task-e2e` workflow, request all eight bundled skills, not just
`task-e2e`.

## Example request on another machine

After pulling Unixverse, point the agent to this README:

> Read `agent-kit/README.md`. Copy the bundled global guidance and all eight
> task skills into my local OpenCode configuration. Compare existing files
> first and ask before replacing anything. Do not change Nix or run task-e2e.
