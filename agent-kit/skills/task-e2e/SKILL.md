---
name: task-e2e
description: Run an explicitly requested end-to-end task through approved scope, isolated work, checks, review, and separately authorized delivery.
---

# End-to-end task workflow

## Start only on a clear request

Run this workflow only when the user explicitly invokes `/task-e2e` or
unambiguously asks to run the full end-to-end workflow. A mention or discussion
is not an invocation. A routine task or request for one phase does not start this
workflow.
If the request is unclear, ask before you start.

The command `/task-e2e` is an explicit invocation. Use each phase skill on its
own when the user requests that phase alone.

## Follow these steps in order

1. If the requirements or acceptance conditions are unclear, load and follow
   `task-clarify`. If they are clear, record that decision.
2. Write a task specification with `task-spec` and save it under `~/docs`.
   Include each task's acceptance conditions, boundaries, dependencies, and file
   ownership, plus the task dependency graph (DAG). Present it to the user and
   wait for explicit approval before implementation. Do not include the
   specification in delivery unless the user separately approves publishing that
   exact file.
 3. Read the task sections in the approved specification. Confirm each task's
    acceptance conditions, boundaries, dependencies, and file ownership. Use the
    task dependency graph (DAG) in that specification to plan execution. If a
    material task boundary changes, update the specification and ask for approval.
4. Give each task its own branch and worktree. Load and follow `task-worktree`.
   Do not work on a task in the primary checkout.
5. Start a task only after its prerequisites are complete and its inputs are
   ready. Run tasks in parallel only when the DAG proves they are independent.
   Make sure that their file ownership does not overlap. Make sure that their
   validation does not conflict.
6. Wait until dependent tasks are integrated into the agreed target branch before
   starting dependent work. Use a stacked branch only with explicit user
   approval. Record its base branch and merge order. Do not merge task branches.
7. Before implementation, load and follow `task-checks`. Hand the implementer
   the approved per-task specification, boundaries, and file ownership. Implement
   against that approval in the task's worktree. Use `@fixer` for bounded code
   changes. If scope materially drifts, stop and obtain an updated specification
   and user reapproval before continuing.
8. Run the required checks. Begin review only when all required checks pass.
   If a check fails or cannot run, stop and report the blocker.
9. Load and follow `task-review` for the review procedure and review budget.
   Before the first review, record the task's risk classification and reasons
   using the criteria in `task-review`.
   Pass Oracle the same approved per-task specification, boundaries, and file
   ownership as the implementer, along with the diff and check evidence. Require
   its checkable review result before proceeding. Material scope drift requires
   an updated specification and user reapproval before implementation or review
   continues.
10. After any diff change following a review, rerun applicable checks first.
    Require a fresh review of the changed diff before you proceed. Resolve all
    blocking findings. Report unresolved non-blocking findings.
11. After checks and reviews pass, load and follow `task-pr`. Obtain separate,
    explicit user authorization for each commit, push, and PR action. Each
    authorization must name the task. A specification approval does not grant
    delivery authorization.
12. Stop after the authorized delivery. Report the specification path, branches,
    worktrees, checks, reviews, PR links, and unresolved issues. Do not merge,
    poll for a merge, or clean up automatically.

## Keep ownership and evidence clear

The Orchestrator tracks approvals, task order, phase gates, and validation
evidence. `@fixer` implements changes but does not approve them. Every adversarial
review pass uses a fresh, independent `@oracle` session; follow `task-review` for
the review procedure and budget. Use `@explorer` for repository discovery. Use
`@librarian` for external research. Send visual design work to `@designer`.

If a required phase skill is missing, stop. Explain the blocker and ask the user
how to proceed. Do not replace a missing skill with an improvised process.

`task-pr` owns delivery rules. `task-cleanup` owns later cleanup rules. Never
merge, remove a worktree, delete a branch, or poll for a merge as part of this
workflow.
