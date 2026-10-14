---
name: start-ticket
description: Discovery for the start of a ticket — stress-tests the ticket's requirements against the real code, one question at a time, and expands them with edge cases, security, and performance concerns. Writes refined requirements, open questions, and acceptance criteria to START_TICKET.md at the worktree root; no implementation plan. Use when the user invokes /start-ticket.
disable-model-invocation: true
---

# Start Ticket

Discovery for the *beginning* of a ticket. The ticket arrives with requirements; this
skill stress-tests them — validates them against the real code, expands them where
they're incomplete, and surfaces the edge cases, security exposure, and performance
risk nobody wrote down. **The conversation is the deliverable** — `START_TICKET.md` is
where the refined requirements get written down at the end. You are the orchestrator:
drive the phases below, but let the user set the pace.

**This skill discovers *what* must be true, not *how* to make it true.** The building
session owns the design. A spec that dictates files, CSS, or a build order locks that
session into decisions made before anyone looked closely at the problem, and buries the
real requirements under choices that were never requirements. When the spec is written,
stop.

## Golden rules

- **One question at a time.** Never batch questions. Each question builds on the
  previous answer. This is the single most important behavior — the original workflow
  earned its value here.
- **Requirements, not implementation.** Pin down what must be observably true and the
  public contracts callers will depend on; leave internals to the build session. See
  *Requirement or implementation?* below.
- **Validate against real code.** Read the code to test the ticket's assumptions, not to
  plan the change. Cite `file:line` as *evidence* for a finding — "`rowSaved` fires
  before `grid_replace` swaps the row (`save_controller.js:77`), so a client-side flash
  on save would land on a node that's about to be discarded" — never as a to-do.
- **Hunt what nobody wrote down — that matters in practice.** Volunteer the edge cases,
  failure modes, security exposure, and performance risk the ticket didn't mention, but
  keep only what a real user or caller will plausibly hit, or what would be expensive if
  they did. A spec that only restates the ticket has failed; so has one that buries five
  real requirements under twenty guarding against things nobody will ever do. Every
  requirement costs build time, tests, and review.
- **Don't write the file early.** Only write `START_TICKET.md` once the user confirms
  the spec is complete.
- **Stop after writing.** Summarize and hand off. Do not implement or plan the
  implementation.

## Requirement or implementation?

Before anything goes in the spec, ask: **would a user, a calling developer, or someone
verifying the behavior notice if the builder did this differently?** If yes, it's a
requirement. If only someone reading the diff would notice, it's implementation — leave
it out.

**Requirements** — keep these:

- Observable behavior: what a user sees, what happens on failure, what must never happen.
- Public contracts other code depends on: component options and their allowed values,
  helper names, Stimulus event names and `detail` shape, grid setters, routes and params,
  persisted data. If the name isn't decided yet, that's an open question — don't invent it.
- Constraints that bound the design without choosing it: "works on read-only rows", "no
  per-row query", "never exposes another company's records".
- Deliberate consistency callers will see: "same flash duration and roles as `wb_table`".

**Implementation** — leave these out: which files change; which element, class, or
method carries the behavior; CSS properties, keyframes, selectors; query shape;
algorithms; what to reuse; build order and step lists.

When you catch yourself writing implementation, ask what it protects and write that
instead:

| Implementation | Requirement it protects |
|---|---|
| Animate `background-color` on `.data-grid__cell` with no 100% keyframe | The flash fades back to the row's own background (read-only grey, tinted rows), never to white |
| Follow `WB::RadioCard`'s `form:`/`method:` options | Inside a form builder, the model's value selects the matching option unless an option passes `selected:` explicitly |
| Normalize multiple `selected: true` on the server | If several options are marked selected, the first wins — in every mode |

Code findings often *imply* a solution — "the row node present at `rowSaved` is replaced
moments later." Record the finding as a constraint with its evidence, and let the build
session decide what to do about it.

## Artifact

One file: `<worktree-root>/START_TICKET.md`, where `<worktree-root>` is
`git rev-parse --show-toplevel` run from the current directory. The user runs this from
inside the worktree they're working in, so the file lands right where they'll build.
It is assumed to be covered by the user's global gitignore — do **not** modify any
`.gitignore` or `.git/info/exclude`.

If a `START_TICKET.md` already exists at the root, don't overwrite it blindly — read it
and offer to resume/refine it instead.

## Flow

### 1. Orient & baseline

1. Run `git rev-parse --show-toplevel` and `git branch --show-current` to confirm which
   worktree/feature you're in. The branch (e.g. `cs/FE-3001/bulk-toolbar`) is context,
   not something to parse into the filename — the artifact is always `START_TICKET.md`.
2. Read the ticket — Linear MCP if available, otherwise ask the user to paste it — and
   what it links to: parent and sibling tickets, comments, linked PRs, design files.
   Sibling work is often where conventions callers already expect were decided. With
   only a description and no ticket, work from what the user gives.
3. Extract the **baseline**: the stated requirements as a numbered list, in the ticket's
   own words, plus the assumptions it makes without saying so (e.g. "assumes a saved row
   arrives as a fresh DOM node"). Show it to the user. Everything after this is measured
   against the baseline — each item ends up validated, expanded, corrected, or cut.

### 2. Validate against the code

Dispatch `Explore` agent(s) with the baseline, not just the feature name — the job is to
check each requirement and assumption against how the system behaves today. Have them
find:

- **Current behavior** the ticket changes or depends on, and whether it matches what the
  ticket assumes.
- **Interactions** — every caller, consumer, and flow that touches the affected area
  (other features, jobs, Turbo streams, events, shared components) and how the change
  would reach them.
- **Conventions callers already rely on** in sibling features — option names, event
  shapes, permission checks — where diverging would be visible.
- **Data and access** — what data flows through, who can reach it, and how much of it
  exists in real use. The security and performance lenses in step 3 depend on these
  facts.
- **Contradictions and gaps** — requirements the code makes impossible, ambiguous, or
  already satisfies.

Ask for findings framed as facts about the system with `file:line` evidence — not a list
of places to make changes. Before presenting a claim about behavior, read the code path
yourself: a wrong finding steers the requirements wrong, which is worse than no finding.

Present the findings against the baseline — which requirements held up, which the code
contradicts or complicates, and what the ticket didn't account for. Then resolve them
with the user, one question at a time.

### 3. Interrogate

Work through the four lenses below, one question at a time, each building on the last.
Lead with the findings most likely to change the requirements. The bullets are prompts
for your own thinking, not a questionnaire to read out — skip what doesn't apply, and
when a whole lens comes up empty, say so in one line with the reason ("no new data
access: this styles rows the user can already see") rather than inventing concerns to
fill it.

Before raising a finding, ask **who actually hits this, and what it costs if we're
wrong**. Answer from real callers, real data, and real user flows — not from what the
code merely permits. Drop what's both unlikely and cheap to fix later. Checks that come
up clean stay in the conversation, not the spec: "rolling deploys are unaffected" or
"no flag needed" is worth one line to the user and zero lines in `START_TICKET.md`.

Ask with a recommendation: state the finding, its evidence, and the requirement you'd
propose, so the user can confirm or correct it in one reply.

Each finding resolves one of three ways: a **requirement** (filed under whichever spec
section fits), an explicit **out of scope**, or an **open question** for someone outside
this conversation (product, design, security). Open questions are a legitimate outcome —
discovery that finds a decision nobody has made yet has done its job.

**Requirements** — gaps and ambiguity in the baseline

- Words that could mean two things; defaults the ticket never states; combinations of
  options or states it doesn't cover.
- Who uses this and from where — roles, pages, entry points — and what existing behavior
  changes for people who never asked for it.
- For UI: keyboard, screen reader, and focus behavior; long and localized text.

**Edge cases & failure modes**

- Empty, one, many, and the maximum; loading; validation errors, server errors, timeouts.
- Concurrency: two people editing the same record, double submits, a stale page acting
  on data that changed underneath it.
- Turbo: stream replacements, morphs, back/forward cache restoring old state.
- Rolling deploys: an old page talking to new code and the reverse, for any param, event,
  or payload that changes (`.claude/rules/rolling-deploys.md`).
- Flags: if it ships behind Flipper, what flag-off looks like and what happens to a user
  mid-session when it flips.

**Security** — Wrapbook holds payroll, tax, and banking data; assume this lens matters
until the evidence says otherwise.

- Authorization: who may see and do this, and which existing permission governs each
  action — including field-level rules. Policies deny by default
  (`app/policies/base_policy.rb`). Distinguish company users, project workers, admins,
  and API clients.
- Tenancy: could a record from another company or project be reached by changing an id —
  in a param, a remote select endpoint, a Turbo stream target? Controllers scope through
  `Current.company` / `Current.project`; every path the feature touches must hold that
  line.
- Sensitive data: SSN/TIN, bank, wage, and tax fields (Lockbox `has_encrypted`). Does
  the feature display, export, log, or cache any of it, or put it in the DOM, data
  attributes, URLs, client JS, or error reports? Exports have their own permission
  (`can_export_sensitive_records?`).
- Untrusted input: user text rendered into HTML, attributes, or JS; permitted params;
  uploads; redirects.
- Audit: does a change to an audited record need to appear in its history, attributed to
  the actor?

**Performance** — size requirements against real usage, not the demo page.

- Volume: how many records does the largest real company or project have here?
  Paginated, or all at once?
- Queries: per-row or per-cell lookups that multiply with volume. Bullet and Prosopite
  catch some N+1s in dev and test, not all.
- Frontend: DOM nodes and Stimulus controllers per row or cell on large grids; work that
  runs on every keystroke, scroll, or edit; animations across many rows at once.
- Frequency and fan-out: requests per interaction, polling, Turbo broadcasts to many
  viewers, jobs that enqueue more jobs.

Turn a real performance concern into a measurable requirement sized to real usage ("the
largest real page using this — a 1,000-row ledger — stays responsive when the saved row
flashes"), not a prescribed fix. Bound what callers actually do, not the worst case the
API technically allows.

Continue until the user is satisfied the requirements are complete.

### 4. Reconcile & accept

1. **Reconcile the baseline.** Show the numbered baseline with each item's outcome —
   held, expanded, corrected, or cut — and ask the user to correct anything, so nothing
   from the ticket silently disappears.
2. **Propose acceptance criteria** — observable done-conditions that someone who didn't
   build it can check. Write the ones a reviewer would actually check before calling the
   ticket done, not one per sentence of the spec. Say what to observe, not which test to
   write; test design belongs to the build session. Refine with the user.

### 5. Draft & challenge

1. Draft the spec using the structure below — in your scratchpad, not at the worktree
   root yet — and run every line through *Requirement or implementation?*.
   Implementation detail creeps back in most easily while summarizing: file paths drift
   out of the evidence section into requirements, and "how" phrasing replaces "what".
2. Send the draft to an **adversarial reviewer**: a fresh `general-purpose` subagent
   given the draft and the baseline, but not the conversation. You can't review this
   yourself — after the interrogation you're anchored on every finding you surfaced. The
   reviewer's job is to make the spec *smaller and more correct*, not longer. Tell it to
   challenge:
   - **Wrong** — requirements or findings the code or ticket contradicts, or evidence
     that doesn't say what the spec claims. Verify against the repo.
   - **Won't happen in practice** — edge cases, bounds, and guards for situations no real
     user or caller hits: paths no production code takes, volumes no real page reaches,
     sequences users don't perform. Check real callers and usage before claiming it.
   - **Over-engineered** — requirements that solve problems nobody has yet, add API
     surface no caller needs, or demand far more than the ticket's goal.
   - **Leaked implementation** — anything that fails *Requirement or implementation?*.

   Rare-but-expensive stays: security, data integrity, and money are worth specifying
   even when unlikely. Ask for each challenge as the spec line, the category, the
   argument with evidence, and a proposed action (cut, shrink, or correct) — and for
   "holds up" on sections it can't fault rather than objections manufactured to fill
   the list.
3. Weigh each challenge yourself before passing it on. The reviewer can be wrong too —
   check its "this is wrong" claims against the code. Where it challenges a decision the
   user already made, keep the decision unless the reviewer brings new evidence.
4. Present the surviving challenges as one list, each with your recommendation, and let
   the user rule on all of them in one reply. This is the one place a batch beats one
   question at a time — the challenges are independent and the user is reviewing, not
   discovering.

### 6. Write & stop

1. Apply the rulings, then confirm with the user that the spec is complete.
2. Write `<worktree-root>/START_TICKET.md`.
3. Summarize — how the baseline fared, what was added, what the challenge cut, and the
   open questions with who owns each — and **stop.** Do not implement or plan the
   implementation; a fresh session builds from the spec.

## START_TICKET.md structure

```markdown
# <Feature title> (<ticket id if any>)

## Summary
<What this ticket delivers and why, in a few sentences. Link the ticket and the sources
of truth: parent ticket, sibling PRs, design files.>

## Open Questions
<Decisions nobody in the conversation could make. Each with who should answer it and
what it blocks. "None" if none.>

## Requirements
<Observable behavior and public contracts, each unambiguous and checkable. Group by area
when there are many.>

## Edge Cases & Failure Modes
<Each case paired with the required behavior.>

## Security
<Who may see and do what, tenancy, sensitive data, untrusted input, audit — or one line
on why this lens doesn't apply.>

## Performance
<Expected real-world volume and measurable bounds — or one line on why this lens doesn't
apply.>

## Out of Scope
<What this ticket deliberately doesn't do, and why.>

## Acceptance Criteria
<Numbered, observable done-conditions.>

## Baseline Review
| # | Ticket said | Outcome | Why |
|---|---|---|---|

## Context & Evidence
<Facts about the current system that shaped the requirements, each with `file:line`.
Evidence, not a change list.>
```

