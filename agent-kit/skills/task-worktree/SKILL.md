---
name: task-worktree
description: Create one isolated Git branch and worktree for each approved task.
---

# Task worktrees

Use this skill only after an explicit worktree request or approved end-to-end
task. It creates isolation, not implementation or integration.

## Steps

1. Make sure that the user explicitly requested worktrees or approved the
   end-to-end task. Stop if neither applies.
2. List every task with its approved base, branch name, worktree path,
   dependencies, and owner. Assign one branch and worktree to each task.
3. Wait to create a dependent task's lane until its prerequisites are complete.
   Create it only when its approved base is ready.
4. Inspect the repository root, current checkout, configured remotes, intended
   base, dirty and untracked files, and registered worktrees. Record the results.
5. Compare every branch name with local and remote refs. Compare every path with
   existing paths and registered worktrees. Resolve collisions before any Git
   mutation.
6. Keep worktree paths outside the primary checkout. Do not use `.slim`. Do not
   modify ignore files or disturb dirty or untracked files.
7. Present the task-to-branch/path/base mapping, dependencies, dirty state,
   collisions, and planned Git mutations. Get approval if the request did not
   approve these exact lanes.
8. Create only the approved lanes with Git worktree commands. Do not switch the
   primary checkout. Do not create stacked branches or PR assumptions without
   explicit approval.
9. Make sure that each lane uses its approved path, branch, and base. If
   creation stops or fails, report created and uncreated lanes.

## Boundaries

Do not commit, push, create PRs, merge, cherry-pick, rebase, delete branches,
remove worktrees, prune, or clean up. Do not merge automatically or assume
approval for stacked PRs. Keep implementation inside each task's assigned
worktree and scope.

Route bounded discovery to `@explorer`. Route focused external research to
`@librarian`. Route approved implementation to `@fixer`. Route visual design to
`@designer`. The Orchestrator owns lane boundaries and coordination.
