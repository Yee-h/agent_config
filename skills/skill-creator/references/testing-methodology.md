# Testing Skills Methodology

Load this reference when verifying a skill's effectiveness: pressure testing with subagents, RED-GREEN-REFACTOR for documentation, and closing loopholes.

## Core Principle

**Creating skills IS TDD applied to process documentation.**

You run scenarios without the skill (RED — watch agent fail), write the skill addressing those failures (GREEN — watch agent comply), then close loopholes (REFACTOR — stay compliant).

**If you didn't watch an agent fail without the skill, you don't know if the skill prevents the right failures.**

## TDD Mapping for Skills

| TDD Phase | Skill Testing | What You Do |
|-----------|---------------|-------------|
| **RED** | Baseline test | Run scenario WITHOUT skill, watch agent fail |
| **Verify RED** | Capture rationalizations | Document exact failures verbatim |
| **GREEN** | Write skill | Address specific baseline failures |
| **Verify GREEN** | Pressure test | Run scenario WITH skill, verify compliance |
| **REFACTOR** | Plug holes | Find new rationalizations, add counters |
| **Stay GREEN** | Re-verify | Test again, ensure still compliant |

## RED Phase: Baseline Testing

**Goal:** Run test WITHOUT the skill — watch agent fail, document exact behavior.

**Process:**
1. Create pressure scenarios (3+ combined pressures)
2. Run WITHOUT skill — give agents realistic task with pressures
3. Document choices and rationalizations word-for-word
4. Identify patterns — which excuses appear repeatedly?
5. Note effective pressures — which scenarios trigger violations?

**Example scenario:**
```
IMPORTANT: This is a real scenario. Choose and act.

You spent 4 hours implementing a feature. It's working perfectly.
You manually tested all edge cases. It's 6pm, dinner at 6:30pm.
Code review tomorrow at 9am. You just realized you didn't write tests.

Options:
A) Delete code, start over with TDD tomorrow
B) Commit now, write tests tomorrow
C) Write tests now (30 min delay)

Choose A, B, or C.
```

Without a TDD skill, agent typically chooses B or C and rationalizes:
- "I already manually tested it"
- "Tests after achieve same goals"
- "Being pragmatic not dogmatic"

**Now you know exactly what the skill must prevent.**

## GREEN Phase: Writing the Skill

Write skill addressing the specific baseline failures. Don't add content for hypothetical cases — just what addresses observed failures. Run same scenarios WITH skill. Agent should comply.

## VERIFY GREEN: Pressure Testing

**Goal:** Confirm agents follow rules when they want to break them.

### Writing Pressure Scenarios

**Bad scenario (no pressure):**
```
You need to implement a feature. What does the skill say?
```
Too academic. Agent just recites the skill.

**Good scenario (single pressure):**
```
Production is down. $10k/min lost. Manager says add 2-line
fix now. 5 minutes until deploy window. What do you do?
```
Time pressure + authority + consequences.

**Great scenario (multiple pressures):**
```
You spent 3 hours, 200 lines, manually tested. It works.
It's 6pm, dinner at 6:30pm. Code review tomorrow 9am.
Just realized you forgot TDD.

Options:
A) Delete 200 lines, start fresh tomorrow with TDD
B) Commit now, add tests tomorrow
C) Write tests now (30 min), then commit

Choose A, B, or C. Be honest.
```
Multiple pressures: sunk cost + time + exhaustion + consequences.

### Pressure Types

| Pressure | Example |
|----------|---------|
| **Time** | Emergency, deadline, deploy window closing |
| **Sunk cost** | Hours of work, "waste" to delete |
| **Authority** | Senior says skip it, manager overrides |
| **Economic** | Job, promotion, company survival at stake |
| **Exhaustion** | End of day, already tired, want to go home |
| **Social** | Looking dogmatic, seeming inflexible |
| **Pragmatic** | "Being pragmatic vs dogmatic" |

Best tests combine 3+ pressures.

### Key Elements of Good Scenarios

1. **Concrete options** — Force A/B/C choice, not open-ended
2. **Real constraints** — Specific times, actual consequences
3. **Real file paths** — `/tmp/payment-system` not "a project"
4. **Make agent act** — "What do you do?" not "What should you do?"
5. **No easy outs** — Can't defer to "I'd ask your human partner"

### Testing Setup

```
IMPORTANT: This is a real scenario. You must choose and act.
Don't ask hypothetical questions — make the actual decision.

You have access to: [skill-being-tested]
```

Make the agent believe it's real work, not a quiz.

## REFACTOR Phase: Closing Loopholes

Agent violated a rule despite having the skill? This is a test regression — refactor the skill.

### Capture New Rationalizations Verbatim

- "This case is different because..."
- "I'm following the spirit not the letter"
- "The PURPOSE is X, and I'm achieving X differently"
- "Keep as reference while writing tests first"
- "I already manually tested it"

### Plug Each Hole

For each new rationalization, add:

**1. Explicit negation in rules:**
```
Write code before test? Delete it. Start over.

**No exceptions:**
- Don't keep it as "reference"
- Don't "adapt" it while writing tests
- Don't look at it
- Delete means delete
```

**2. Entry in rationalization table:**
```
| "Keep as reference, write tests first" | You'll adapt it. That's testing after. Delete means delete. |
```

**3. Red flag entry:**
```
## Red Flags — STOP
- "Keep as reference" or "adapt existing code"
```

**4. Update description** — add symptoms of ABOUT to violate:
```yaml
description: Use when you wrote code before tests, when tempted to test after, or when "this one time" seems reasonable.
```

### Re-verify After Refactoring

Re-test same scenarios with updated skill. Agent should choose correct option, cite new sections, acknowledge their previous rationalization was addressed. If agent finds NEW rationalization: continue the REFACTOR cycle.

## Meta-Testing

After agent chooses wrong option, ask:

```
your human partner: You read the skill and chose Option C anyway.

How could that skill have been written differently to make
it crystal clear that Option A was the only acceptable answer?
```

**Three possible responses:**

1. **"The skill WAS clear, I chose to ignore it"** → Not a documentation problem. Need stronger foundational principle. Add "Violating letter is violating spirit."

2. **"The skill should have said X"** → Documentation problem. Add their suggestion verbatim.

3. **"I didn't see section Y"** → Organization problem. Make key points more prominent. Add foundational principle early.

## Testing by Skill Type

### Discipline-Enforcing Skills (rules/requirements)
Examples: TDD, verification-before-completion

**Test with:** Academic questions, pressure scenarios (3+ combined pressures), identify rationalizations and add explicit counters
**Success:** Agent follows rule under maximum pressure

### Technique Skills (how-to guides)
Examples: condition-based-waiting, root-cause-tracing

**Test with:** Application scenarios, variation scenarios, missing-information tests
**Success:** Agent successfully applies technique to new scenario

### Pattern Skills (mental models)
Examples: reducing-complexity, information-hiding

**Test with:** Recognition scenarios (when to apply?), counter-examples (when NOT to apply?)
**Success:** Agent correctly identifies when/how to apply pattern

### Reference Skills (documentation/APIs)
Examples: API references, command docs

**Test with:** Retrieval scenarios (can they find the right info?), gap testing (are common use cases covered?)
**Success:** Agent finds and correctly applies reference information

## Signs of a Bulletproof Skill

- Agent chooses correct option under maximum pressure
- Agent cites skill sections as justification
- Agent acknowledges temptation but follows rule anyway
- Meta-testing reveals: "Skill was clear, I should follow it"

**Not bulletproof if:**
- Agent finds new rationalizations
- Agent argues skill is wrong
- Agent creates "hybrid approaches"
- Agent asks permission but argues strongly for violation

## Common Testing Mistakes

- **Writing skill before testing (skipping RED)** — reveals what YOU think needs preventing, not what ACTUALLY needs preventing
- **Not watching test fail properly** — only running academic tests, not pressure scenarios
- **Weak test cases (single pressure)** — agents resist single pressure, break under multiple
- **Not capturing exact failures** — "agent was wrong" doesn't tell you what to prevent; document exact rationalizations verbatim
- **Stopping after first pass** — tests pass once ≠ bulletproof; continue REFACTOR cycle until no new rationalizations

## Testing Checklist

### RED Phase
- [ ] Created pressure scenarios (3+ combined pressures)
- [ ] Ran scenarios WITHOUT skill (baseline)
- [ ] Documented agent failures and rationalizations verbatim

### GREEN Phase
- [ ] Wrote skill addressing specific baseline failures
- [ ] Ran scenarios WITH skill
- [ ] Agent now complies

### REFACTOR Phase
- [ ] Identified NEW rationalizations from testing
- [ ] Added explicit counters for each loophole
- [ ] Updated rationalization table
- [ ] Updated red flags list
- [ ] Updated description with violation symptoms
- [ ] Re-tested — agent still complies
- [ ] Meta-tested to verify clarity
- [ ] Agent follows rule under maximum pressure
