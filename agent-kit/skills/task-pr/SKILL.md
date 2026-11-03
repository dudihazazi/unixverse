---
name: task-pr
description: Deliver a named task through separately authorized commits, pushes, or pull requests.
---

# Deliver a named task

## Start and scope

Use this skill only when the user explicitly invokes it or loads it for the
delivery phase of `/task-e2e`. Delivery does not start other task phases.

Before you act, identify the task, repository, worktree, branch, and target
branch. Ask if any detail is unclear. Inspect project instructions and required
checks. Report which checks passed, failed, or could not run.

Standalone use does not require the full E2E workflow. Report missing
specification, checks, or review evidence. Do not claim E2E completion.
During E2E delivery, enforce its required approvals, checks, and reviews.
Stop when required evidence is missing, stale, or blocked.

## Authorize each action

Before each Git change, get explicit user authorization for that action and task.
Ask separately before committing, pushing, or creating a PR. A request to
implement or approve a specification does not authorize delivery. Do not carry
authorization from another task, branch, or action.

Do not merge or force-push. Do not delete branches or change remotes. Do not
make other unrequested Git changes. The user reviews and merges the PR.

## Complete these steps in order

1. Check repository instructions and required check results. In E2E use, make
   sure that all required checks and reviews are current and green.
2. Inspect the complete commit list from the target branch to the task branch.
   Inspect the complete branch-to-target diff, including committed changes.
   Inspect staged and unstaged changes, `git status`, and recent history.
3. Make sure that every included commit and changed file belongs to the named
   task. In E2E use, make sure that current review evidence covers every commit
   and file. Stop if any change is unrelated or out of scope. In E2E use, stop
   if any change lacks current review evidence. In standalone use, report missing
   review evidence without claiming E2E completion.
4. Identify generated, secret, or unintended files. Leave them untouched. Stop
   when scope or ownership is uncertain.
5. Stage only files for this task and authorized delivery. Do not stage the
   local specification unless the user explicitly approves that exact file.
6. If authorized, commit only the intended staged changes. If authorized, push
   only the task branch to its established remote. Never force-push.
7. If the user authorized it, create the PR against the agreed target branch.
   Report its title, scope, and validation accurately. Do not claim checks
   passed without evidence.
8. Stop after authorized actions. Report the commit hash, pushed branch, PR link,
   check and review status, and unresolved issues. State that merge and cleanup
   remain for the user. Never start `task-cleanup` automatically.

If authorization, branch, remote, target, or staging scope is unclear, stop that
action. Ask the user for the missing detail.
