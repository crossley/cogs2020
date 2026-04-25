# cat_learn_auto (COGS2020)

## Overview

This dataset comes from a longitudinal experiment investigating how a category
learning skill develops and becomes *automatic* with extended practice.

### What is automaticity?

When you first learn a new skill — driving a car, touch-typing, returning a
serve — performance is slow, effortful, and demands conscious attention.
With enough practice, the same behaviour becomes fast, accurate, and seemingly
effortless. This transition from controlled to automatic processing is called
**automaticity**.

In cognitive neuroscience, the leading account of automaticity in skill
learning proposes that two brain systems are involved. Early in learning, the
brain relies on cortico-basal ganglia pathways, where dopamine-dependent
reinforcement signals gradually strengthen correct stimulus–response
associations. With sufficient practice, these pathways are thought to train
faster, more direct cortical connections that allow the brain to bypass the
slower reinforcement learning circuit altogether. The result is behaviour that
is not only faster and more accurate, but qualitatively different: it no
longer requires attention or cognitive resources in the way that early learning
does.

This account makes two important and testable predictions:

1. **Automatic performance should be resistant to cognitive load.** Early in
   learning, performance suffers when attention is divided. If a skill has
   become truly automatic, adding a simultaneous cognitive demand should
   produce little or no disruption — because the skill no longer depends on
   the limited-capacity attention system.

2. **Automatic performance should be resistant to response remapping.** As
   stimulus–response associations become deeply entrenched, they become harder
   to override. Switching to new response buttons should therefore be more
   disruptive after extensive training than it would be early in learning —
   precisely because the associations have become automatic and rigid.

These are the two phenomena this experiment was designed to measure.

### This dataset

Participants completed a category learning task across approximately one month
of at-home training. At the end of training, two behavioural tests were
administered to assess whether performance had become automatic. The dataset
contains only behavioural (response and reaction time) data from at-home
sessions; EEG data collected during in-lab sessions are not included.

### Background reading

These are **background papers**. They are **not** the paper describing this
final project dataset. They are meant to help you understand the theoretical
context and frame your final project.

- Ashby, F. G., Ennis, J. M., & Spiering, B. J. (2007). A
  neurobiological theory of automaticity in perceptual
  categorization. Psychological Review, 114(3), 632–656.
  https://doi.org/10.1037/0033-295X.114.3.632

- Hélie, S., Waldschmidt, J. G., & Ashby, F. G. (2010).
  Automaticity in rule-based and information-integration
  categorization. Attention, Perception, & Psychophysics,
  72(4), 1013–1031. https://doi.org/10.3758/APP.72.4.1013

- Waldschmidt, J. G., & Ashby, F. G. (2011). Cortical and
  striatal contributions to automaticity in
  information-integration categorization. NeuroImage, 56(3),
  1791–1802.
  https://doi.org/10.1016/j.neuroimage.2011.02.011

- Ashby, F. G., & Crossley, M. J. (2012). Automaticity and
  multiple memory systems. WIREs Cognitive Science, 3(3),
  363–376. https://doi.org/10.1002/wcs.1172

- Cantwell, G., Crossley, M. J., & Ashby, F. G. (2015). Multiple stages of
  learning in perceptual categorization: Evidence and neurocomputational
  theory. *Psychonomic Bulletin & Review, 22*(6), 1598-1613.
  https://doi.org/10.3758/s13423-015-0827-2

- Roeder, J. L., & Ashby, F. G. (2016). What is automatized
  during perceptual categorization? Cognition, 154, 22–33.
  https://doi.org/10.1016/j.cognition.2016.04.005

---

## Study Design

**Participants:** 13

**Training phase (days 02–20):** Participants classified visual stimuli into
one of two categories (`A` or `B`) based on feedback. Stimuli varied along two
continuous dimensions (`x` and `y`). Participants completed sessions
approximately 4 days per week, so the training phase spanned roughly one month
per participant.

**Automaticity Test 1 — Dual-task (day 22):** Participants completed the
category learning task simultaneously with a Numerical Stroop task (judging
digits by their numerical value or physical size). They were given 40 minutes
and instructed to complete as many trials as possible, so the number of trials
varies across participants on this day. The logic is that early in learning,
dividing attention between two tasks should hurt category learning performance.
If the skill has become automatic, however, it should require less cognitive
resource and performance should be relatively unaffected by the concurrent
load.

**Automaticity Test 2 — Button-switch (days 23–24):** Participants completed
the same category learning task, but the response button assignments were
reversed — the button previously mapped to Category A was now mapped to
Category B, and vice versa. If stimulus–response associations have become
automatic and entrenched, participants should find this switch particularly
difficult, because the deeply learned mappings now conflict with the required
response. That is, automaticity is expected to produce not just faster and more
accurate performance, but also greater *rigidity* — a cost when established
contingencies are changed.

---

## Session and Day Structure

| Day(s)   | Session type            | `session_type` value in data      |
|----------|-------------------------|-----------------------------------|
| 02–20    | At-home training        | `"Training at home"`              |
| 22       | Dual-task               | `"Dual-Task at home"`             |
| 23–24    | Button-switch           | `"Button-Switch at home"`         |

**Note:** Days 01, 06, 11, 16, and 21 were in-lab EEG sessions and are not
included in this dataset. This is why those day numbers are absent from every
participant's folder.

---

## Folder and File Structure

Data are organised into one folder per participant, with one CSV file per
session day:

```
data_home_behave/
  subj_001/
    sub_001_day_02_data.csv
    sub_001_day_03_data.csv
    ...
    sub_001_day_24_data.csv
  subj_003/
    ...
```

Each CSV file contains one row per trial for that participant on that day.

Participant IDs present: 001, 003, 004, 005, 007, 008, 009, 010, 012, 013,
014, 016, 017.

---

## Variable Codebook

### Core trial columns (present in every file)

| Column        | Type    | Description |
|---------------|---------|-------------|
| `subject`     | integer | Participant ID number |
| `day`         | integer | Day index (matches the number in the filename) |
| `trial`       | integer | Trial index within that day (zero-indexed) |
| `cat`         | string  | True category label for the stimulus (`"A"` or `"B"`) |
| `x`           | float   | Stimulus value on dimension X (original stimulus space) |
| `y`           | float   | Stimulus value on dimension Y (original stimulus space) |
| `xt`          | float   | Stimulus value on dimension X after transformation/scaling used in the task |
| `yt`          | float   | Stimulus value on dimension Y after transformation/scaling used in the task |
| `resp`        | string  | Participant's category response (`"A"` or `"B"`) |
| `rt`          | float   | Reaction time for the category response, in milliseconds |
| `fb`          | string  | Feedback given to participant (`"Correct"` or `"Incorrect"`) |
| `acc`         | integer | Category task accuracy on this trial (`1` = correct, `0` = incorrect) |
| `n_trials`    | integer | Total number of category task trials completed by this participant on this day |
| `session_type`| string  | Session type label (see Session and Day Structure above) |
| `resp_key`    | string  | Raw keyboard key pressed for the category response (e.g., `"d"` or `"k"`) |
| `f_name`      | string  | Name of the source CSV file |
| `block`       | float   | Block label; not meaningfully used in this cleaned export |

### Dual-task columns (day 22 only)

These columns are present in every CSV file as a result of how the data were
cleaned, but they contain meaningful values **only on day 22**. On all other
days, these columns are empty.

| Column            | Type    | Description |
|-------------------|---------|-------------|
| `ns_left_digit`   | float   | Digit shown on the left side of the Stroop display |
| `ns_right_digit`  | float   | Digit shown on the right side of the Stroop display |
| `ns_left_size`    | string  | Physical size of the left digit (`"small"` or `"big"`) |
| `ns_right_size`   | string  | Physical size of the right digit (`"small"` or `"big"`) |
| `ns_congruent`    | boolean | Whether the digit value and physical size are congruent (`True` / `False`) |
| `ns_cue`          | string  | Which dimension the participant was instructed to judge (`"Value"` or `"Size"`) |
| `ns_correct_side` | string  | The correct response side for the Stroop trial (`"left"` or `"right"`) |
| `ns_resp`         | string  | The participant's Stroop response side (`"left"` or `"right"`) |
| `ns_rt`           | float   | Reaction time for the Stroop response, in milliseconds |
| `ns_fb`           | string  | Feedback for the Stroop trial (`"Correct"` or `"Incorrect"`) |
| `acc_stroop`      | float   | Stroop trial accuracy (`1.0` = correct, `0.0` = incorrect) |
| `acc_stroop_mean` | float   | Mean Stroop accuracy across all trials in that session |

---

## Possible Research Questions

The following are examples of questions you could investigate with this
dataset. You are not required to use these — they are intended to help you
start thinking about what an analysis could look like.

- Does category learning accuracy improve across the training days? If so,
  does the rate of improvement differ across participants?

- Does reaction time change over the course of training, and does it change in
  the same way as accuracy?

- How do accuracy and reaction time on the category task compare between the
  training phase and the dual-task session (day 22)? What might any difference
  — or absence of difference — tell you about automaticity?

- Does the button-switch manipulation (days 23–24) affect accuracy or reaction
  time relative to late training? What might this tell you about how strongly
  the stimulus–response mappings were learned?

- Is there a relationship between Stroop performance on day 22 and category
  learning performance on that same day?

---

## Notes and Caveats

- **Varying trial counts on day 22:** Because participants were given a fixed
  time window rather than a fixed number of trials, `n_trials` differs across
  participants on day 22. Keep this in mind when summarising or comparing
  performance on that day.

- **Missing day numbers:** The absence of days 01, 06, 11, 16, and 21 is
  intentional — these were in-lab EEG days, not at-home sessions.

- **Dual-task columns on non-dual-task days:** Columns beginning with `ns_`
  are empty for all days except day 22. Do not treat empty cells in these
  columns as missing data on training or button-switch days.

- **`resp_key` on day 22:** The raw key column may be empty for dual-task day
  trials; use `resp` for the category response on all days.

- **Participant IDs are not consecutive:** The final sample of 13 participants
  does not span a contiguous ID range. This is normal and reflects exclusions
  made during data collection.
