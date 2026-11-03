---
name: task-cleanup
description: Remove an explicitly named, merged task worktree and separately authorized branches after safety checks.
---

# Clean up a merged task

## Start only on explicit request

Use this skill only when the user explicitly invokes `task-cleanup` after merge.
Never start cleanup from `task-e2e`, `task-pr`, or another phase. Do not poll
for merge status. Do not infer a merge from an open or closed PR.

Cleanup deletes user data. Before acting, get the exact worktree path and local
branch name. For remote deletion, also get the exact remote and branch name. Get
separate explicit authorization for each removal. Never infer remote deletion
from worktree deletion. Do not use authorization from another task.

## Verify before removal

Run the full set of read-only checks below before removing anything. Report each
result. Remove nothing unless every check passes:

1. Make sure that the worktree belongs to the intended repository. Make sure
   that it is not the primary checkout.
2. Make sure that the named local branch is checked out in that worktree. Make
   sure that the local branch is not protected or the repository default
   branch. Never remove a protected or default branch.
3. Identify the intended target branch. Prove that the task changes are present
   on that branch. Use Git history and change evidence.
4. For a normal merge, use merge ancestry as evidence. For squash or rebase
   merges, compare the task changes with target commits. Prove equivalence. A
   merged PR or empty diff alone does not prove integration.
5. Make sure that no task changes remain outside the target, including
   unpushed commits. Check the task branch against the target and its upstream.
   Treat a missing upstream or unclear history as a blocker.
6. Make sure that the worktree has no tracked changes, staged changes,
   untracked files, or ignored user files. Do not discard or clean files.
7. Inspect all worktrees. Make sure that no other worktree uses the named branch
   or path.

If a check fails or remains uncertain, stop without removing anything. Report
the exact blocker and ask the user how to proceed. Never use `git clean`, reset,
force operations, or pruning to make a failed check appear safe.

## Remove only authorized objects

After all checks pass, perform only the requested, authorized actions:

1. Remove only the named clean secondary worktree with the normal Git worktree
   removal command. If state changed since verification, stop and recheck.
2. Delete the local branch only when the user named it and authorized deletion.
    Before deletion, repeat the applicable checks. Verify the repository and
    branch identity. Prove integration and no remaining task changes. Check the
    branch's upstream and remote relation. Inspect all worktrees and confirm
    there is no data loss. The original worktree no longer exists, so do not
    require it to have the branch checked out. Stop if any state changed or is
    unclear.
3. Delete the remote branch only when the user separately named the remote and
    branch, then authorized deletion. Immediately before deletion, recheck the
    exact remote branch target. Confirm that it is not protected. Stop if the
    target changed or is unclear.

If state changes after verification, stop and recheck. Do not prune worktrees,
remove metadata, or clean unrelated files. Report the checks and exact objects
removed. Leave the primary checkout, protected branches, unrelated worktrees,
and uncertain or dirty state untouched.
