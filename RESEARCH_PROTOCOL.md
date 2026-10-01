# Research protocol — required reading before any run

Adopted 2026-09-23. Governs every test in this repository. **Hierarchy:** this file → `H08_INTEGRITY_PROTOCOL.md`
(weather-specific addendum under this protocol) → per-test preregistrations and decision rules (e.g.
`AXIOM_V2_DECISION_RULE_20260925.md`). A lower document may be stricter than this one, never looser. The lessons behind
the checks are `EXPERIMENT_LEDGER.md` §9; this file cites them as §9.n and does not restate them. New ideas enter
through §6 (idea intake) before stage 0.

## 1. Stages and gates

| stage | entry requirement | exit |
|---|---|---|
| **0 Screen** (fast lane) | none — no prereg | KILLED by a one-line ledger entry, or → stage 1 |
| **1 Candidate** | rule, cell, bar and kill criterion frozen in a short prereg (ledger line + file) **before** the held-out / new-asset data is touched; replication passes (§3) | → stage 2, or KILLED |
| **2 Paper** | spec added to `research_specs.json` via a ledger entry (cells, `bar_c`, `target`, `read_by`); `RESEARCH_ECONOMICS_TEMPLATE.md` filled | read at `target`/`read_by` (§4) → stage 3, or KILLED |
| **3 Live probe** | the user's explicit word; 1–10 lots; loss stop written before the first order (cumulative net and losing-events-per-24h limits); shard funded (balance is per sub-exchange) | P&L over **fills**, never over opportunities → stage 4, or STOPPED |
| **4 Scale** | net-positive after fees over **≥ 200 real fills**; size from measured depth per event, not from the backtest | — |

Full gates apply only to promotion. A screen cannot skip to paper or live on its own numbers. KILLED means do not
revisit without a new capability (new data, new venue, new instrument), named in the reviving entry.

**Fast-lane kill format (one line in the ledger):**
`YYYY-MM-DD HH:MMZ — <id> <hypothesis> — KILLED — k=<cells>, best <cell> <c/contract> (t, N in clustering units) — <why> — CL[...]`

## 2. Pre-result checklist — attached to every reported result

Every result — fast-lane kill, candidate, paper read, live read — carries this checklist, each item **P**ass / **F**ail /
**NA** with a short note on each F or NA. Compact form for one-line entries: `CL[1P 2P 3P 4NA 5P 6P 7NA 8k=32 9NA 10P 11P 12NA]`.
A kill that has an F must say which way the failure biases the result; a failure that biases toward zero does not invalidate the kill.

| # | check | §9 |
|---|---|---|
| 1 | **Point-in-time inputs.** Every feature was available at decision time: publication/availability time, not init or valid time; nothing realised after entry (final volume, closing bar stamp, revised data). | 18, 20, 22 |
| 2 | **Executable price.** Entry priced at the real touch at decision time (book, L2 replay or journaled quote); candles or mids only where validated for that series. | 2, 12 |
| 3 | **Exact fees.** Per-series schedule, maker vs taker, with rounding. | 7 |
| 4 | **Contract terms.** Rule text and `contract_terms_url` read; strike inequality and station derived from settlement records. | 5, 6, 17, 21 |
| 5 | **Data completeness.** Pagination exhausted; archive span and timestamp resolution checked; gaps named as local gaps, not exchange facts. | 8, 14, 16 |
| 6 | **Clustering unit.** CIs resample the independent unit (event / window / day); N reported in that unit, not in rows. | 4 |
| 7 | **Chronological cut.** Train/test split on settlement time per row; test data untouched until the frozen rule is run once. | 18 |
| 8 | **Cells tested.** k reported (§3). | — |
| 9 | **Timing.** Delay swept for post-event signals; instrument/clock skew measured before any latency claim. | 9, 10 |
| 10 | **Placebo / mirror.** The opposite side, a shifted time, or an untriggered control shows nothing. | — |
| 11 | **Market baseline.** Model vs market Brier and the disagreement split; the market is the null. | 1, 19 |
| 12 | **Real ledger.** Any replay of sizing/caps/risk runs the production code path, not a reimplementation. | 3 |

## 3. Multiple testing

- **Report k**, the number of cells tested in the family: every threshold, delay, asset, side, horizon and variant
  looked at, including ones abandoned early. "Run both variants and keep the better" is k = 2.
- A best cell out of k is a **screen result**, whatever its t-statistic. Nothing is called a **CANDIDATE** until the
  rule, frozen before the look, replicates on **held-out time or new assets** and clears its pre-registered bar there.
- Replication is run once. A failed replication is a kill, not a prompt to re-tune.

## 4. No-peeking rules for protected tests

**Protected tests** are the strategies in `research_specs.json`; their read cells, sizes (`target`) and dates
(`read_by`) are defined there, not here. AXIOM one-shot preregs are protected by their own run scripts, which refuse a second run.

1. **The read happens once, at the spec's `target` or `read_by`.** No P&L, hit rate or CI on a read cell before then.
2. **Allowed at any time:** health and ops (runner up, scan gaps, entry counts, drift outside the spec envelope) and the
   pre-registered **kill watch** (`research_readiness.py`). A kill-zone cell may be stopped early; it may never be
   promoted or extended early.
3. **No spec change after data starts** except through a dated ledger entry written before the next read. A change made
   after interim numbers were seen turns that cell into a screen result: no longer confirmatory.
4. **No extension because a read is "close".** One extension, only if the spec or prereg defined it in advance.
5. **Accidental peeks are logged** in the ledger (what, when, who); the read stands but is flagged.
6. `reference: true` cells are comparisons, never read as results.

## 5. Recording

- `EXPERIMENT_LEDGER.md`: dated entry for every result and every spec change; header times from `date -u`, never estimated.
- `RESEARCH_MASTER.md`: the hypothesis row's status (KILLED / CANDIDATE / OPEN / PAPER / BLOCKED).
- `research_specs.json`: stage 2+ only, changed only with a ledger entry.
- Memory note: any new lesson that cost something, plus a new §9 rule if it generalises.

## 6. Idea intake — observation first, the model is an anomaly investigator

Adopted 2026-09-30, revised same day. Every model we use is available to every other trader, so an idea a model
produces from its own knowledge is the idea every other user's model produces too; the sports, momentum,
underreaction and passive-MM kills are that class. What survived came from facts only this repo holds: settlement
mechanics read from the source, exchange-wide scans (logical arb,
semantic mismatch, `source` field) and our own recorded data. Novelty is **not** a goal ("sounds obscure" is noise); the
standard is *supported by a fact specific to this exchange or our data*. §6 governs everything before stage 0; §1–§5
apply after.

**6.1 Hard ban.** No trading rule is proposed unless it cites the exact rows/files, primary-source text, filed terms or
measured anomaly that motivated it. With no such evidence the output is a **measurement to collect**, not a strategy.

**6.2 Pipeline — four steps, separate agents/contexts, in this order.** Collapsing them into one narrative is the
failure mode (observation → story → rule → tuning).

1. **Observe.** Input: a generator dataset (6.5), discovery slice only. Output: ranked anomalies — magnitude,
   recurrence across ≥ 2 disjoint discovery periods, nearest trap (6.4). **No trades, no mechanisms.** Structural facts
   (a rule, a timing gap, a payout) count as observations. The scan's size (measures × series × windows) is its **k**
   (§3); an anomaly that does not recur across periods is not passed on.
2. **Explain.** A fresh agent gets **one** anomaly. It writes ≥ 3 competing explanations from exchange mechanics,
   incentives, settlement rules or information flow; each must predict something distinct on data **not** used in step
   1. If none is credible: "likely noise", stop.
3. **Design.** A fresh agent designs the cheapest test that separates the explanations and fills the mechanism card
   (6.3). All thresholds frozen and hashed **before** the validation slice is opened. No rule optimisation.
4. **Test.** Run once on the sealed slice (§3 replication, §4 no-peeking). Pass → stage 1 candidate; fail → one-line KILLED.

A red-team agent with 6.4 and ledger §9 reads the card between steps 3 and 4; its strongest objection is recorded.

**6.3 Mechanism card** (in the ledger entry or prereg; a missing field blocks step 4):

    OBSERVATION      the anomaly/fact, with file + rows/query, discovery slice, k of the scan
    MECHANISM        chosen explanation, and the rivals it must beat
    COUNTERPARTY     who is on the other side and why they keep losing ("less accurate" is not an answer)
    WHY PERSISTENT   why it is not already harvested: capacity, access, rules, attention; decay measured on the
                     latest discovery period
    NOVEL PREDICTION what else must be true if the mechanism is real, on data not used to find it
    FALSIFIER        the result that kills it, frozen
    CAPACITY         $/day ceiling from measured depth at the touch, fees and the 10-contract quote cap; < $20/day noted,
                     not built. Target is several uncorrelated $20–40/day pieces (see combine-strategies)
    NEAREST KILL     closest KILLED ledger entry, and the new capability that makes this different (§1)
    COMMONNESS       hit / no hit against `research_ideas/CROWDED_IDEAS.md` (6.6)
    BACKTEST MODE    taker at recorded touch with depth + fees + latency (backtestable), or maker (queue not
                     replayable → paper forward only)

**6.4 Known-trap list** (hand to every observer, explainer and red team): paper fills at stale listing prices;
candlesticks as the touch; hindsight strike caps in live-rule replays; journal rows treated as independent; bootstraps
over fake prices; the 15-minute crypto fee wall; the 10-contract combo quote cap; `rules_primary` omitting governing
clauses; the series `source` field; batch-skew lag; Windows clock skew; close precedes publication;
`early_close_condition`; the vintage-collapse key; scan-size k ignored. Details in memory notes and ledger §9.

**6.5 Generators and sealing.** Models build **datasets, not strategy prose**; observers query them. Every generator
that carries prices or times seals its validation slice **when it is built** (latest ≥ 25 % of its span, or a named
market family), records the seal in its README, and the observe step never reads it. Structural-only tables (no
outcomes) need no seal.

- **Settlement-source census** (first; structural): per series — settlement source, its publication time/format,
  market close, programmatic fetchability + access-rule check, knowable-vs-close gap.
- **Exchange microstructure table** (priced; sealed): per series/day — spread, touch depth, stale-book frequency,
  post-event adjustment speed, jump frequency, volume concentration, maker incentives, contract lifetime.
- **Consistency scans** (existing): logical arb, semantic mismatch, cross-venue pairs; rerun on new listings.

**6.6 Commonness check.** `research_ideas/CROWDED_IDEAS.md` holds what off-the-shelf models (Claude, ChatGPT, …) give
an ordinary user who asks for Kalshi edges with no repo context; refresh it monthly with `research_ideas/crowd_baseline/`.
A hit does not kill a hypothesis — it demands that WHY PERSISTENT show the effect has not decayed in the latest period
at our size. Persistence at size, not novelty, is the crowding test.
