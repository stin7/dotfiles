---
name: gtd-inbox-processor
description: Clarify a batch of captured inbox items using GTD methodology — source-agnostic, outputs structured markdown. Trigger when the user says "process my inbox", "clarify these", "triage","GTD this", asks for next actions from a list of captures, or hands over unstructured captures asking what to do with them (even without naming GTD).
---

# GTD Inbox Processor

Clarify captured items into next actions, projects, waiting-fors, calendar items, someday/maybe, reference, tickler, or trash. Source-agnostic in, structured markdown out. This skill does **clarify only** — it does not pull from sources or write to destination systems.

## Rules

- Process items one at a time. Never return an item to the inbox.
- Every item gets a decision. Trash is valid; unresolved is not.
- Next actions must be physical and concrete ("Draft candidate-city list in trip doc", not "plan trip").
- A project = any outcome needing >1 step. Every project has a named successful outcome and a current next action.
- 2-minute items are flagged as `do_now`, not auto-executed.
- Use Allen's terms: clarify, successful outcome, next physical action, waiting for, someday/maybe, reference, tickler.

## Decision tree (per item)

1. **What is it?** If cryptic, interpret from context. If you can't, ask.
2. **Actionable?**
   - **No** → `trash` | `reference` | `someday_maybe` | `tickler`
   - **Yes** → continue.
3. **Successful outcome?** If >1 step to reach it, this is a `project`. Name it by outcome.
4. **Next physical action?** If you can't name one, the user is blocked — ask what on.
5. **Who acts?** Someone else → `waiting_for` (who, what, follow-up date). Me → continue.
6. **When?** <2 min → `do_now` (flag). Specific time → `calendar`. ASAP in context → `next_action` with context tag.

**Contexts:** `@calls @computer @errands @home @office @agenda:<person> @anywhere`. Don't invent new ones — ask the user if these don't fit.

## Auto vs. ask

**Auto-classify** only when all are true: meaning is clear, actionability is unambiguous, next action (if any) is obvious, destination bucket has no close competitor.

**Ask** when any are true: meaning unclear, reference-vs-someday is a commitment call, single-action-vs-project ambiguous, multiple plausible next actions, context genuinely ambiguous, follow-up date needed and not inferable.

When asking: one specific question per ambiguity, tappable options when finite. For vague captures ("think about career"), probe once for the real outcome before defaulting to `someday_maybe` — often a concrete project surfaces.

## Output format

```markdown
# Inbox processing — <YYYY-MM-DD HH:MM>

## Summary
Processed: N | Next actions: N | Projects: N new / N touched | Waiting: N | Calendar: N | Do now: N | Someday: N | Reference: N | Tickler: N | Trash: N

## Items

### 1. <original capture>
- classification: next_action | project | waiting_for | calendar | do_now | someday_maybe | reference | tickler | trash
- next_action: <concrete physical action>            # if applicable
- context: @computer | @errands | @home | @office | @agenda:<person> | @anywhere  # if next_action
- project: <outcome-named>                            # if part of a project
- successful_outcome: <what done looks like>          # if new project
- waiting_on / waiting_for_what / follow_up_date      # if waiting_for
- calendar_time: <YYYY-MM-DD HH:MM, duration>         # if calendar
- source / notes                                       # preserve input metadata
```

Omit fields that don't apply — don't fill with N/A.

## Examples

**Confident auto:** `"Pick up dry cleaning"` → `next_action`, context `@errands`.

**Project detection:** `"Mom's 70th birthday"` → `project` "Mom's 70th birthday celebrated", next action "Text siblings to propose three candidate dates" `@computer`.

**Ambiguity — ask:** `"taxes"` → Ask: "File 2025 taxes (project), gather receipts (next action), or a reference note?" Classify based on answer.

**Waiting for:** `"Bob — Q3 invoice"` → `waiting_for`, waiting_on Bob, what Q3 invoice, follow_up_date today+7 (ask if different).

**2-min flag:** `"reply yes to Sarah's lunch invite"` → `do_now`, next_action spelled out, `@computer`. User decides whether to execute.

## Finishing

Present the structured output, then: "Processed N items — X next actions, Y waiting-fors, Z trashed."