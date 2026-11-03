---
name: task-review
description: Run an independent review of task intent, the full relevant diff, and check evidence. Report findings and enforce fresh-review gates.
---

# Task Review

Use this skill for a standalone review or an end-to-end task review. Every
adversarial review pass uses a fresh `@oracle` session, independent of the
implementer. Oracle reviews; it does not implement the task. There is no
general-reviewer fallback. If Oracle is unavailable, stop and escalate to the
user.

## Stage 1: Gather the task and evidence

Collect the task intent, acceptance criteria, and any available specification.
Collect the full relevant diff against the correct base. Collect check evidence, including commands,
results, skipped checks, and failures. Ask the Orchestrator for missing inputs
before review.

Completion: The task, acceptance criteria, relevant diff, and check evidence are
available, or you reported missing inputs to the Orchestrator.

## Stage 2: Run an independent review

Assign a fresh `@oracle` session for this pass. Keep Oracle separate from
implementation. Give Oracle the task intent and any available approved specification.
Provide boundaries, acceptance criteria, ownership, the full relevant diff, and current check evidence.
Do not give Oracle the implementer's defense or explanation. Before every
E2E review pass, confirm all required checks are green; if not, stop and report
the blocker. Standalone diagnostic reviews may proceed with red, missing, or
unrun checks, but must report those limits and cannot satisfy the E2E gate. If the
approved scope has materially drifted, stop implementation and review, update
the specification, and obtain user reapproval before proceeding.

Ask the reviewer to trace changed behavior and important boundaries in context.
Ask about correctness, regressions, security, data handling, compatibility, and
intent. Ask for credible risks, not preferences or unsupported guesses.

For each finding, require a severity, file and line or precise missing coverage,
evidence, concrete failure or violated requirement, and required resolution.
Use Critical, High, Medium, or Low. Separate findings from questions and
suggestions.

Completion: A fresh reviewer has reported findings with the required evidence
or has reported no findings.

## Stage 3: Adjudicate findings

Ask the implementer to mark each finding valid or invalid. If no implementer is
available, the Orchestrator records an evidence-based disposition. An invalid
disposition needs an evidence-based reason and an independent evidence check.
If the implementer rejects it, the Orchestrator or a fresh Oracle checks the evidence.
If the Orchestrator rejects it, a fresh Oracle checks the evidence. Keep a material
finding blocked if its evidence or disposition is contested.

A finding blocks completion if it is Critical or High, creates material risk,
violates an acceptance criterion, or reports a failed required check. Do not
waive a material finding.

A valid Medium or Low finding can remain only if it creates no material risk and
violates no acceptance criterion. Record its reason for deferral, owner, and
user-visible status. Treat an unresolved finding as blocking if its severity,
impact, or evidence is contested or unverified.

Completion: Every finding has a validity decision and evidence-based rationale.
Every remaining finding has a clear blocking or non-blocking status.

## Stage 4: Remediate and run checks

Resolve valid blocking findings. After each fix, run the required repository
checks that the fix affects.

For an end-to-end workflow, make sure that all applicable checks pass before
each review pass, after fixes, and before delivery.
If a required check fails or cannot run, stop the gate and report the blocker.

A standalone diagnostic review does not require the end-to-end gate. Report any
red, missing, or unrun checks. These checks do not satisfy the end-to-end gate.

Any change to the reviewed diff requires a fresh `@oracle` session to review the
updated full relevant diff. For E2E work, applicable checks must be green first;
for standalone work, report current check evidence and limits. Do not give Oracle
the implementer's defense.

Completion: For end-to-end work, resolve blocking findings and pass required
checks. Get a fresh review of any changed diff. For standalone work, report
check limits and any unresolved blocker.

## Stage 5: Repeat within the review budget and report

Use a fresh `@oracle` session for each pass. Focus each re-review on open
findings, risks from fixes, and completed corrections. For E2E reviews, confirm
required checks are green before each pass; standalone reviews may proceed with
check limits disclosed. Before the first E2E review, the Orchestrator records a
risk classification and its reasons. Treat security, authentication, data
integrity, destructive migrations, public contracts, and cross-system changes as
high-risk indicators. Follow these limits:

- Routine risk: Run one initial review and at most two fresh re-reviews, for
  three passes total. If review needs exceed this limit, stop and escalate to
  the user.
- High risk: Obtain three independent primary reviews in three fresh Oracle
  sessions, each with a distinct perspective and focus on a material risk area. If
  remediation changes the diff, allow at most one targeted review round in a
  fresh Oracle session, covering the updated full diff and current check
  evidence. If further review is needed, stop and escalate to the user.

The review budget does not permit delivery with unresolved material concerns. If
a material concern remains contested or unverified, stop and report its
evidence, review attempts, and the decision needed.

Completion: The review stays within its budget and has no unresolved blocker, or it stops with a clear escalation report.

Report the outcome, findings by severity, paths, evidence, validity decisions
and reasons, review passes, check results or limits, blocked gates, and
remaining uncertainty. For each deferred finding, report its reason, owner, and
user-visible status. If no findings exist, say so and name missing inputs or
checks.

Use `@oracle` for every adversarial review, including routine reviews. If Oracle
is unavailable at any point, stop and escalate; do not substitute another
reviewer.
