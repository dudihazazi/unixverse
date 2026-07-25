# Global Agent Instructions

## Priority and scope

Follow instructions in this order:

1. User instructions.
2. Repository-local `AGENTS.md` and other repository instructions.
3. This global file.

This file defines universal workflow, safety, Git, planning, and quality rules.
Local instructions define repository architecture, conventions, tools, commands,
and deployment details. Local instructions take precedence when they conflict
with this file, unless doing so conflicts with user instructions or safety.

## Default operating mode

Work autonomously when requirements and plan intent are clear. Send concise
milestone updates while working. Ask targeted questions only when needed.

Escalate only for a genuinely major issue: irreversible data or system impact,
a security risk, a breaking public contract, a fundamentally different
architecture, or requirements that cannot meet the plan's intent.

Keep changes minimal. Prefer existing code, patterns, native platform features,
and installed dependencies. Do not add dependencies or change lockfiles without
user approval. Record approved dependency or lockfile changes in the plan.

## Safety

- Never expose secrets or read more sensitive material than necessary.
- Do not run destructive commands without user confirmation.
- Ask before migrations, deployments, or system changes.
- Do not hide work with `git stash`, ignored/untracked patches, generated files,
  or silent configuration changes.
- Keep generated artifacts only when planned or necessary; otherwise remove them
  before handoff.

## Planning

### Fast path

Evaluate fast-path eligibility before planning.

Skip the written plan and implementation/review loop only for an isolated,
low-risk edit: a small change to one file or function with no public API,
security, data, schema, dependency, lockfile, or deployment impact.

For fast-path work, still inspect local instructions, make the smallest safe
change, run relevant validation, and leave the diff for human review. Switch to
the full workflow immediately if scope expands or risk becomes unclear.

Every implementation outside the fast path requires a written plan before
edits begin.

Use `grill-with-docs` when available. Otherwise: clarify requirements, inspect
repository-local instructions and relevant code, research current official docs
when relevant, then write the plan.

Store plans outside repositories:

```text
~/docs/plans/<repo-name>/<NNN>-<short-kebab-slug>/plan.md
```

- Derive `<repo-name>` from the Git root directory name.
- Number tasks independently per repository using the next zero-padded counter.
- If repository names collide, use `name--owner-repo` when remotes distinguish
  them; otherwise append a short sanitized path hash.
- Retain plans until the user directs otherwise.
- The completed plan authorizes implementation; explicit approval is not needed.

`plan.md` must include:

- problem;
- goals and non-goals;
- relevant local instructions, official sources, and version assumptions;
- concise decision log;
- affected files;
- implementation steps;
- work items with owner, affected paths, dependencies, parallel-safe status,
  worktree/branch name, merge order, and validation;
- validation plan;
- risks and rollback;
- acceptance criteria.

Keep `plan.md` current with deviations, work-item status, validation results,
review findings, and concise rationales for rejected invalid review findings.
Update it and continue for ordinary plan flaws. Escalate only major issues.

## Parallel execution and worktrees

Split approved plans into independent work items only when that improves speed
without risking conflicting edits. Use one agent for tightly coupled changes.

Use isolated worktrees for concurrent edits or overlapping-risk work. The
primary orchestrator owns integration, conflict resolution, and final
validation. Do not merge automatically.

Use automatic names unless the user specifies otherwise:

```text
agent/<task-num>-<slug>
agent/<task-num>-<work-item-slug>
```

Keep completed work on its branch/worktree for human review.

## Handoffs

Every handoff must state:

- task ID and plan path;
- scope and affected paths;
- current status;
- validations run and results;
- unresolved issues;
- exact next action.

Use the durable `plan.md` and diff for normal handoffs. Use a dedicated handoff
mechanism only when ownership or context must move to another implementer or
worktree.

## Implementation and review loop

For each implementation pass:

1. One implementer makes the changes.
2. Two fresh, independent reviewers examine the diff against acceptance
   criteria. Give reviewers the diff and acceptance criteria, not the
   implementer's reasoning.
3. The original implementer fixes every valid finding. Fix the union of
   findings; document why any demonstrably invalid finding was rejected.
4. Re-run applicable validation and review again.

Run at most three implementation/review passes. Escalate only an unresolved
major issue. If the loop repeatedly reveals workflow drift, improve this
process or local instructions rather than merely patching code.

Review for correctness, regressions, security, tests, maintainability, plan
compliance, performance, readability, and repository code standards.

## Validation and documentation

Before human handoff, run applicable repository-provided checks for changed
code:

- formatting;
- unit tests;
- linting;
- type checking;
- security scanning;
- documentation updates when necessary.

Check local instructions and existing repository tools first. Do not add a new
security scanner merely to satisfy this rule. Inspect relevant code and run
`git status` before editing. Record pre-existing failures only if encountered
during required validation.

## Git and delivery

- Never commit, push, create a pull request, or merge unless the user explicitly
  asks.
- Before an explicitly requested commit, inspect `git status`, `git diff`, and
  recent history; stage only intended files.
- Agents may create or switch branches and worktrees as needed.
- Never rebase shared history or alter remotes unless explicitly instructed.
- Keep implementation ready for human review on its working branch/worktree.
- When explicitly asked to create a commit or PR, include only a concise plan
  summary, not the full plan.
