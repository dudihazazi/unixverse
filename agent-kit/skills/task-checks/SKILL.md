---
name: task-checks
description: Guide implementation and record repository checks for a coding task.
---

# Task checks

Use this skill for implementation, repository checks, or both. It works alone.
It does not require a plan, worktree, or end-to-end workflow.

## Steps

1. Record the requested behavior, constraints, and acceptance criteria. Ask
   about an ambiguity only when it blocks safe progress.
2. Read applicable repository instructions. Find project-provided unit test,
   lint, typecheck, format, build, and security checks.
3. For behavior changes, write a focused test from the specification when
   suitable. Run it and record the intended failure as red.
4. Implement the smallest scoped change. Run the focused test. Record a passing
   result as green.
5. Refactor only when useful. Keep the focused test green after each refactor.
6. Run every applicable project-provided check. Use the project's format check
   or formatter. Then make sure that changed files are clean.
7. Record every check's command or source, result, exit status, and useful
   output. Mark a check N/A only when it does not apply to this task.
8. Before end-to-end review, make sure that all applicable checks are green. If
   a check fails, fix it within scope. Rerun it and any checks affected by the
   fix.
9. After fixes, make sure that all applicable checks are green again. Report
   blockers, changed paths, and remaining uncertainty to the Orchestrator.

## Results

Use GREEN for a passing check. Use RED for a failure. Use BLOCKED for a
required check that did not run or lacks evidence. Use N/A only for a check that
does not apply. State why each N/A check does not apply.

Report exact evidence for these categories:

| Category | Evidence |
|---|---|
| Unit tests | Command or source, result, exit status, and test summary |
| Lint | Command or source, result, exit status, and output |
| Typecheck | Command or source, result, exit status, and output |
| Format | Command or source, result, exit status, and clean-file result |
| Build | Command or source, result, exit status, and output |
| Security | Command or source, result, exit status, and findings |

If automation is unsuitable, report focused manual evidence and the reason. A
failed or blocked required check prevents the end-to-end review gate.

## Standalone use

For checks-only requests, do not change implementation. Find and run applicable
checks. Record exact results and report blockers. A standalone diagnostic run
can include failures, but it does not pass the end-to-end review gate.

The Orchestrator coordinates task ownership and phase gates. Assign bounded,
non-visual implementation to `@fixer`. Route visual design to `@designer`. Use
`@explorer` for bounded discovery. Use `@librarian` for focused research.
