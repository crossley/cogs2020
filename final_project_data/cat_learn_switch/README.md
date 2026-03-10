# cat_learn_switch (COGS2020)

## Overview

This dataset comes from an experiment investigating how category learning
proceeds when participants must constantly switch between two different tasks.

### What is this experiment about?

Participants learned to categorise visual stimuli by pressing one of four
keyboard keys. What made this unusual is that rather than practising a single
task, participants switched randomly between two different versions of the task
on every trial — one version signalled by a square background, the other by a
diamond background.

The central question is simple: **what exactly does the brain learn when it
learns to categorise?** Does it learn a general response direction — for
example, *this type of stimulus goes on the left* — or does it learn a
specific finger movement — *this type of stimulus means press with my right
middle finger*?

To test this, the experiment used two conditions that were identical in how
many fingers and keys were required, but differed in one important way:

- In the **Congruent condition**, stimuli that looked similar were always
  responded to with keys on the *same side* of the keyboard in both tasks.
  This means the response direction (left vs right) was consistent across the
  two tasks for similar-looking stimuli.

- In the **Incongruent condition**, stimuli that looked similar required
  keys on *opposite sides* of the keyboard in the two tasks. The response
  direction was inconsistent — the same-looking stimulus meant "go left" in
  one task and "go right" in the other.

Because the number of keys and fingers involved is the same in both
conditions, any difference in learning between them would suggest that
*response direction* — not *which specific finger* — is the crucial thing
being learned.

### Background reading

Check back later.


---

## Study Design

**Participants:** 90 (45 per condition)

**Stimuli:** Circular sine-wave gratings varying in spatial frequency and
orientation. Gratings in the first task ("Square subtask") were presented on a
square background; those in the second task ("Diamond subtask") were presented
on a diamond background. The background shape served as the cue indicating
which task applied on each trial.

**Categories:** Each subtask had two categories, giving four categories in
total. The correct response for each category was one of four keyboard keys
(`a`, `s`, `k`, `l`), corresponding to the left middle finger, left index
finger, right index finger, and right middle finger respectively.

**Task structure:** On each trial, a cue was shown indicating the correct
finger–key mapping for the upcoming task, followed by the stimulus. The
participant pressed one of the four keys. Feedback (a green or red circle)
followed each response.

**Conditions (between subjects):**

| Condition   | Response direction for similar-looking stimuli across tasks |
|-------------|-------------------------------------------------------------|
| Congruent   | Same side of the keyboard in both tasks                     |
| Incongruent | Opposite sides of the keyboard in the two tasks             |

**Session:** A single session of 400 trials. Subtasks were interleaved
pseudo-randomly, so participants switched tasks on approximately half of
all trials.

---

## Folder and File Structure

Data are stored in a single `data/` folder, with one CSV file per participant:

```
data/
  sub_3_data.csv
  sub_4_data.csv
  ...
  sub_184_data.csv
```

Each CSV file contains one row per trial for that participant (399–400 trials).
Participant IDs are not consecutive; this is expected and reflects the full
dataset after exclusions.

---

## Variable Codebook

### Columns present in every file

| Column      | Type    | Description |
|-------------|---------|-------------|
| `condition` | string  | Experimental condition: `"4F4K_congruent"` or `"4F4K_incongruent"` |
| `subject`   | integer | Participant ID number |
| `trial`     | integer | Trial index (zero-indexed, runs 0–399) |
| `sub_task`  | integer | Which subtask was presented on this trial: `1` = Square, `2` = Diamond |
| `cat`       | integer | Correct category for this trial, encoded as the ASCII code of the correct response key (see note below) |
| `x`         | float   | Stimulus spatial frequency (original stimulus space) |
| `y`         | float   | Stimulus orientation (original stimulus space) |
| `xt`        | float   | Transformed/scaled stimulus value on dimension X |
| `yt`        | float   | Transformed/scaled stimulus value on dimension Y |
| `resp`      | integer | Key pressed by the participant, encoded as its ASCII code (see note below) |
| `rt`        | integer | Reaction time in milliseconds |
| `fb`        | string  | Feedback given on this trial: `"Correct"` or `"Incorrect"` |

### Notes on key columns

**`cat` and `resp` encoding:** Both `cat` and `resp` are stored as integer
ASCII key codes rather than letter labels. The four valid response keys and
their codes are:

| Key | ASCII code | Finger |
|-----|-----------|--------|
| `a` | 97        | Left middle  |
| `s` | 115       | Left index   |
| `k` | 107       | Right index  |
| `l` | 108       | Right middle |

`resp` values that fall outside this set (e.g., very large integers or other
ASCII codes) represent invalid key presses — the participant pressed a key
that was not one of the four designated response keys. For accuracy-based
analyses, using the `fb` column directly is simpler than recoding `resp`.

**`sub_task`:** This column identifies which of the two tasks was active on
each trial (`1` = Square background, `2` = Diamond background). Switch trials
(where `sub_task` differs from the previous trial) and stay trials (where
`sub_task` repeats) must be derived from this column — there is no explicit
switch/stay label in the data.

**`trial`:** Trial numbering begins at 0. The 400th trial is therefore
`trial == 399`. Use this column when examining how performance changes across
the session.

---

## Possible Research Questions

The following are examples of questions you could investigate with this
dataset. You are not required to use these — they are intended to help you
start thinking about what an analysis could look like.

- Does accuracy improve across the session? Does the rate of improvement
  differ between the Congruent and Incongruent conditions?

- Is there a **switch cost** in accuracy or reaction time — that is, are
  switch trials (where the subtask changes from the previous trial) harder
  than stay trials? Does the size of the switch cost differ between conditions?

- Does reaction time change across the session, and does it track accuracy
  improvement in the same way?

- Is performance different between the two subtasks (Square vs Diamond)?
  Does any subtask difference interact with condition?

- How does performance in the final portion of the session (when participants
  are most practised) compare between conditions?

---

## Notes and Caveats

- **Invalid `resp` values:** As described above, `resp` values outside the set
  {97, 107, 108, 115} represent invalid key presses and should be treated with
  care. The `fb` column is the most reliable indicator of trial accuracy.

- **Trial 0 has no previous trial:** When computing switch vs stay labels,
  the very first trial has no preceding trial. You will need to decide how to
  handle this (e.g., exclude it from switch-cost analyses).

- **Between-subjects design:** Condition is a between-subjects variable —
  each participant was assigned to either Congruent or Incongruent, not both.
  Keep this in mind when choosing appropriate statistical tests for
  comparisons between conditions.

- **Non-consecutive participant IDs:** Participant IDs skip values throughout
  the range. This is normal and reflects the numbering system used during
  data collection.

- **`condition` string prefix:** The condition values are prefixed with
  `"4F4K_"` (referring to the 4-finger, 4-key design). When creating plots
  or summary tables, you may wish to recode these to shorter labels such as
  `"Congruent"` and `"Incongruent"`.
