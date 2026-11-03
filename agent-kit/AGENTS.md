# Global OpenCode guidance

## Safety and priorities
- Follow the user's explicit request first, then applicable repository-local instructions, then this guidance. Follow local rules unless they conflict with safety or higher-priority instructions.
- Protect secrets, credentials, and existing user work. Do not expose secrets or overwrite unrelated changes.
- Ask before destructive actions, migrations, deployments, or system-level changes.
- Commit, push, and create pull requests only when explicitly authorized for that action and scope. Never merge or automatically clean up branches, worktrees, or files.

## Working style
- Handle routine, clearly scoped tasks autonomously. Plans and worktrees are not mandatory; use them only when useful or requested.
- Keep changes focused on the requested scope and validate appropriately. Do not modify unrelated files.

## Task workflows and skills
- The `task-e2e` workflow is opt-in: use it only when the user calls `/task-e2e` or unambiguously invokes that workflow. Do not automatically chain phases for other requests.
- Phase skills are independently usable when requested; do not require the full workflow to use an individual phase.
- For OMO-slim delegation, use the proper role mapping: `@explorer` for codebase discovery, `@librarian` for documentation/research, `@oracle` for architecture/debugging advice, `@designer` for visual/UI design, and `@fixer` for implementation. Delegate only when useful and permitted.
