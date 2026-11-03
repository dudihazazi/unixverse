---
name: task-clarify
description: Resolve material task ambiguity through focused, evidence-based questions before the user's requested next step.
---

# Task Clarification

Use this skill when an unanswered user decision can change the result, scope,
behavior, or acceptance of the task. Do not interview the user when the request
and available evidence leave no material decision open.

Clarification does not create documents or change repository state. It does not
authorize implementation.

When the full task-e2e workflow is explicitly invoked, clarification authorizes
only the specification phase. A mention or discussion of task-e2e is not an
invocation. The user must explicitly approve the specification before
implementation.

## Procedure

1. Restate the requested outcome and known boundaries. Mark interpretations that
   are not yet settled. Finish when the user can correct your understanding.
2. Research discoverable facts before asking the user. Inspect relevant project
   instructions, code, tests, interfaces, and documents. Use focused discovery
   or request `@explorer` when needed. Cite the evidence that affects the task.
   Finish when you have separated known facts from unknown facts.
3. Build the decision frontier. List only unanswered decisions that need the
   user's judgment. For each, state why it matters and what evidence does not
   decide it. Do not ask the user to find facts that you can discover.
   Finish when the remaining questions are user decisions, not research tasks.
4. Model the terms and rules needed to discuss those decisions. Name relevant
   actors, entities, states, transitions, and invariants. Mark missing parts as
   unknown. Finish when the model explains the behavior that can change.
5. Ask one small round of questions from the current frontier. Give clear
   options and their tradeoffs when useful. Ask an open question when options
   would limit the user's answer. Do not ask later questions whose answers
   depend on an unanswered choice. Finish the round when the user can answer it
   without unnecessary work.
6. Update the decision frontier from the user's answers. Record each answer,
   its consequence, and any accepted assumption. Ask the next small round only
   when a material decision remains. Finish when the material frontier is
   closed or the user explicitly accepts the remaining assumptions.
7. Summarize the settled goal, boundaries, evidence, decisions, terms, states,
   invariants, and remaining assumptions. Finish when this record supports the
   user's requested next step.

## Conditional guidance

- If repository evidence conflicts with the request, cite both sources and ask
  which one to follow.
- If a decision has several viable choices, explain the practical tradeoffs
  without choosing for the user.
- If the user defers a decision, state the working assumption and its
  consequence. Do not present it as fact.
- If a term has competing meanings, describe the meanings and ask which one
  applies.
- Do not write project domain documentation as a side effect. Ask whether the
  user wants settled domain rules recorded in project documentation when that
  is a useful but separate change.
- Ask `@librarian` for an unfamiliar external fact only when that fact matters.
  The user makes product and scope decisions.

## Stop condition

Report the result and any open assumptions in the conversation. Do not write or
update plans, specifications, code, or documentation. Do not create branches or
worktrees.

If this is standalone clarification, stop here. Do not start another phase. If
the full task-e2e workflow was explicitly invoked, continue to `task-spec` after
the material decision frontier is closed or the user accepts the remaining
assumptions. Do not begin implementation until the user explicitly approves the
specification.
