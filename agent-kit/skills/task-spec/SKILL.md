---
name: task-spec
description: Write a durable task specification when the user requests one or explicitly invokes the full task-e2e workflow.
---

# Task Specification

Use this skill when the user asks for a specification or written plan. Also use
it when the user invokes `/task-e2e` or unambiguously asks to run the full
end-to-end workflow. A routine task or a mention of the workflow does not
authorize a written plan.

This skill writes a specification. It does not implement the task, change
repository files, create branches or worktrees, or start another phase. A
specification does not authorize commits or pushes.

## Procedure

1. Establish the goal, boundaries, constraints, and acceptance outcomes. Finish
   when you can state what must change and what must remain unchanged.
2. Research relevant evidence before writing. Inspect the project root, local
   instructions, and relevant code, tests, interfaces, and documents. Cite facts
   that shape the specification. Finish when you have separated evidence from
   assumptions and unknowns.
3. Resolve material user decisions before writing. Use `task-clarify` to
   research first and ask focused questions in small rounds. Record the
   decisions, terms, states, and invariants that affect the work. Finish when
   the material decision frontier is closed or the user accepts the remaining
   assumptions.
4. Define every task and its boundaries in the same plan document before the
   user approves the specification. Use one specification with a section for
   each task. Finish when every task has the fields in Task definition below.
5. Choose a document size that fits the task's risk and scope. Keep a small task
   brief. Use separate documents only when one plan would be exceptionally
   large, and link them from the main plan. Finish when the content is complete
   without unrelated detail.
6. Write the specification at the required location. Finish when it covers the
   applicable items below and does not overwrite another task.
7. Report the exact path, a short summary, open assumptions, and authorization
   status. Finish when the user can identify the specification and its limits.

## Document location

Write the Markdown specification to:

```text
~/docs/plans/<repo-name>/<NNN>-<short-kebab-slug>/plan.md
```

- Resolve `~` to the user's home directory. Use the Git root directory name for
  `<repo-name>`.
- If the task has no repository, use a concise project or context name. State
  that choice.
- Inspect the target plans directory before choosing the next zero-padded
  number. Never overwrite an existing task document.
- Create only the required parent directories and `plan.md`. Do not write the
  specification inside the repository. Do not alter unrelated documents.

## Specification contents

Use headings that fit the task. Include the relevant goal, boundaries, evidence,
assumptions, decisions, acceptance criteria, validation, risks, and recovery
approach. Do not invent facts or commands. State whether the user approved the
end-to-end task and name the approval scope.

### Task definition

Give each task its own section in the same plan. Define each task precisely
enough that its implementer can work without guessing. Include:

- Task ID.
- Goal and observable acceptance criteria, including important failure and
  boundary behavior.
- In-scope and out-of-scope work.
- Owned files or other surfaces, and the responsibility for each. Mark
  undiscovered paths as provisional. Resolve them before delegating
  implementation.
- Dependencies and base. Name the planned branch or worktree and its unique
  slug when applicable. Use a shared approved base by default. Do not imply
  stacked branches, pull requests, or integration approval.
- Validation owner and the specific checks that owner will run. Do not invent
  commands.
- Implementer role, or `unassigned`.
- Review handoff: who reviews the work, what they receive, and when the handoff
  occurs. Use `unassigned` for an unknown owner.

For multiple tasks, state the dependency order and integration owner. State
which tasks can run in parallel. Split work only when coordination benefits.
Every task must retain its own scope, ownership, validation, and review handoff.

## Conditional guidance

- If the user explicitly invokes the full end-to-end workflow, write its
  required specification, even for a small task.
- If the user asks for a standalone specification, write one even for routine
  work. Keep it brief when the task is small.
- If the user has not requested a specification or the full end-to-end
  workflow, do not create one.
- If a path or fact is unknown, label it unknown or provisional. Resolve
  provisional owned paths before delegating implementation.
- If a material change to an approved task's goal, boundaries, owned surfaces,
  dependency, validation, or handoff is needed, stop and ask the user to
  reapprove the changed specification before implementation continues.
- If work needs approval before implementation, state that the specification is
  not approval. In `task-e2e`, wait for the user's explicit approval before
  implementation begins.
- If you finish a standalone specification, report it and stop. Do not
  implement, delegate implementation, create a branch or worktree, or initiate
  integration.
