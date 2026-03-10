# cat_learn_unlearn (COGS2020)

## Overview

This dataset comes from an experiment investigating whether a learned
category skill can be truly *erased*, or whether it merely goes quiet —
hidden but still intact underneath.

### What is this experiment about?

Once you have learned a skill through practice and feedback, can that
learning be undone? This question matters well beyond the laboratory.
Bad habits, maladaptive behaviours, and old skills that interfere with
new ones all share a common problem: we learn them procedurally —
gradually, through repetition and feedback — and it is notoriously
difficult to get rid of them. Simply stopping a behaviour is not the
same as unlearning it.

This experiment tests a specific claim about how procedural category
knowledge can be disrupted. Participants first learned to classify
visual stimuli into two categories through trial-and-error feedback.
After reaching a reasonable level of accuracy, they entered an
**intervention phase** in which the feedback was manipulated — either
made completely random (Experiment 1) or mixed randomly with valid
feedback (Experiment 2). As expected, accuracy dropped during this
phase, suggesting the learned associations were no longer being
expressed.

The critical question was then asked in the **test phase**. Before the
first test trial, participants were shown an explicit on-screen message
telling them that the feedback had been random during the intervention,
and that valid feedback was now resuming. This is the key design
feature of the study: by directly informing participants that reliable
feedback had returned, the experimenters gave the underlying memory
system every opportunity to re-express itself — if it was still there
to express. Performance recovery in the test phase therefore cannot
be attributed to participants slowly figuring out that feedback was
valid again; they were told directly.

Did performance recover quickly after that cue? And crucially, did it
recover faster for participants tested on the *same* categories they
originally learned (Relearn condition) versus an entirely *new* set of
categories (New Learn condition)?

- If the intervention caused **true unlearning** — actually erasing the
  learned associations — there should be no advantage for the Relearn
  condition. Everyone would start from scratch equally.

- If the intervention merely **masked** the learning — suppressing its
  expression without destroying the underlying memory — then the Relearn
  condition should recover faster, because the old knowledge is still
  there and can be quickly re-expressed once valid feedback returns.

### Background reading

Check back later.

---

## Study Design

**Participants:** 80 total (40 per experiment, 20 per condition within
each experiment)

**Stimuli:** Circular sine-wave gratings varying in spatial frequency and
orientation, categorised into two groups (`A` and `B`). Participants
responded using the `d` and `k` keys.

**Three phases, 300 trials each (900 trials total):**

| Phase        | Trials    | What happened |
|--------------|-----------|---------------|
| Learn        | 0–299     | Participants received valid feedback and learned to categorise |
| Intervention | 300–599   | Feedback was manipulated (see Experiments below) |
| Test         | 600–899   | Valid feedback was restored; participants told this explicitly |

**There is no explicit phase label in the data.** Phase must be derived
from the `trial` column using the ranges above.

**Two experiments (between subjects):**

| Experiment | Intervention type |
|------------|-------------------|
| 1          | Fully random feedback — every trial's feedback was random regardless of response |
| 2          | Mixed feedback — a combination of random and valid feedback |

**Two conditions (between subjects within each experiment):**

| Condition   | Test phase |
|-------------|------------|
| `relearn`   | Test phase used the *same* category structure as the Learn phase |
| `new_learn` | Test phase used a *new*, rotated category structure |

Each participant belonged to one experiment and one condition, making
this a 2 × 2 between-subjects design.

---

## Folder and File Structure

Data are stored in a single `data/` folder with one CSV file per
participant:

```
data/
  sub_1_data.csv
  sub_2_data.csv
  ...
  sub_80_data.csv
```

Each file contains 899 rows (one per trial, zero-indexed from 0 to 898).

---

## Variable Codebook

| Column       | Type    | Description |
|--------------|---------|-------------|
| `experiment` | integer | Which experiment the participant was in (`1` or `2`) |
| `condition`  | string  | Which test condition the participant was in (`"relearn"` or `"new_learn"`) |
| `subject`    | integer | Participant ID number |
| `trial`      | integer | Trial index (zero-indexed, 0–898) |
| `cat`        | string  | True category label for this stimulus (`"A"` or `"B"`) |
| `x`          | float   | Stimulus spatial frequency (original stimulus space) |
| `y`          | float   | Stimulus orientation (original stimulus space) |
| `xt`         | float   | Transformed/scaled stimulus value on dimension X |
| `yt`         | float   | Transformed/scaled stimulus value on dimension Y |
| `resp`       | string  | Participant's response — `"A"` or `"B"` for valid presses; other values indicate invalid key presses (see note below) |
| `rt`         | integer | Reaction time in milliseconds |
| `fb`         | string  | Feedback given on this trial: `"Correct"` or `"Incorrect"` |

### Notes on key columns

**`resp` values:** Valid responses are `"A"` and `"B"`. Any other value
in this column (e.g., numeric codes) represents an invalid key press —
the participant pressed a key other than the two designated response
keys. For accuracy analyses, using the `fb` column is simpler and more
reliable than recoding `resp`.

**`fb` during the intervention phase:** During the intervention
(trials 300–599), feedback was not based on the participant's actual
response. `"Correct"` and `"Incorrect"` in this phase reflect what the
participant *saw*, not whether they actually responded correctly. Be
mindful of this when computing accuracy across phases.

**Phase derivation:** There is no phase column in the data. Use the
`trial` column to assign phase labels: trials 0–299 = Learn,
300–599 = Intervention, 600–899 = Test.

---

## Possible Research Questions

The following are examples of questions you could investigate with this
dataset. You are not required to use these — they are intended to help
you start thinking about what an analysis could look like.

The most important questions for this dataset concern what happens in
the Test phase — this is where the unlearning versus masking distinction
plays out.

- Is accuracy in the Test phase higher for the `relearn` condition than
  for the `new_learn` condition? This is the central comparison: a
  Relearn advantage would suggest the original learning was still intact
  (masking), while no advantage would be consistent with unlearning.

- How does Test phase accuracy compare to accuracy at the *end* of the
  Learn phase? If masking occurred, Relearn participants might recover
  to near their end-of-training level quickly; if unlearning occurred,
  they would not.

- Does the pattern of recovery in the Test phase differ between
  Experiment 1 (random feedback) and Experiment 2 (mixed feedback)?
  Does one intervention appear more disruptive than the other?

- How does accuracy change across the three phases overall (Learn,
  Intervention, Test)? Does the pattern differ between conditions or
  experiments?

- Does accuracy during the Learn phase increase over trials, and is
  the rate of improvement similar across conditions and experiments?

- Does reaction time follow the same pattern across phases as accuracy?

---

## Notes and Caveats

- **Feedback is misleading during the intervention phase:** On trials
  300–599, feedback was random or partially random. The `fb` column
  reflects what was displayed to the participant, not true accuracy.
  Take care when computing accuracy summaries that span multiple phases.

- **No phase column:** Phase must be derived from trial number. A
  clear and well-documented derivation of phase labels in your R code
  will make your analysis easier to follow.

- **Not all participants are included in all analyses:** Participants
  who did not reach 60% accuracy in the final 100 trials of the Learn
  phase were excluded from the original study's key analyses. You may
  wish to consider this when deciding how to structure your own analysis.

- **2 × 2 between-subjects design:** Experiment and condition are both
  between-subjects factors — each participant belongs to exactly one
  combination. Keep this in mind when choosing appropriate statistical
  comparisons.

- **`resp` contains invalid key presses:** As noted above, any `resp`
  value that is not `"A"` or `"B"` is an invalid press. Use `fb` for
  accuracy rather than recoding `resp` directly.
