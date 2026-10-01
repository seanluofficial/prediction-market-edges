# Why prediction-market edges vanish

Research methodology from a pre-registered, AI-assisted search for trading strategies on a regulated
prediction-market exchange (Kalshi), by **Sean Lu** (seanlu727@gmail.com).

Over about two months I tested 394 distinct trading hypotheses. Each was priced at executable prices with exact fees,
checked on sealed hold-out data, and in some cases traded live with small capital. Two-thirds were killed or closed,
and none became a confirmed edge. The dominant causes of death:
- a calibrated market beating public models;
- fees exceeding small real biases;
- adverse selection of resting orders;
- backtest artefacts such as stale prices, candlesticks and hindsight in rule construction.

The accompanying paper, *Why Prediction-Market Edges Vanish: A Pre-Registered, AI-Assisted Search for Trading
Strategies on Kalshi*, is **not yet public**. It reports aggregate statistics derived from exchange data, and its
release is pending the exchange's written permission under its data terms. This repository therefore contains only
the parts that are mine to publish: the method, not the data or results.

## Contents

| path | what |
|---|---|
| [`RESEARCH_PROTOCOL.md`](RESEARCH_PROTOCOL.md) | The written protocol that governed every test. It covers stage gates (screen → candidate → paper → live probe → scale); a 12-item pre-result checklist; multiple-testing accounting (report *k*, single-shot replication); no-peeking rules for sealed reads; and §6, an observation-first idea intake for using LLMs as research labour rather than idea oracles. It refers to internal files (ledger, specs) that are not published here. |
| [`crowding/`](crowding/) | A **crowding baseline**: what off-the-shelf LLMs (two Claude models and OpenAI Codex) tell an ordinary user who asks for prediction-market edges, run with no project context. `prompts.txt` and `run_baseline.sh` reproduce it. `CROWDED_IDEAS.md` condenses 18 answers into 36 idea clusters and marks which ones the research had already tested. |

## Key method points

- **LLMs as labour, not oracles.** Models wrote collectors, read contract terms, ran scans and attacked results. They
  were not allowed to propose a trading rule without citing the rows, files or primary-source text that motivated
  it.
- **Observe → explain → design → test** run in separate model contexts. The explain step requires at least three
  rival mechanisms, each with a prediction on data not used to find the anomaly. Thresholds are frozen and hashed
  before the single test.
- **Execution-faithful prices only.** A bootstrap or reality check cannot detect prices that were never executable.
  Several of the largest apparent edges came from stale listing quotes, candlesticks, or selecting trades with
  hindsight inside a per-event cap.
- **Crowding check.** An idea that off-the-shelf models suggest is presumed crowded until shown to persist at the
  intended trade size in the most recent data.
- **Persistent memory contaminates baselines.** The first baseline run was discarded because a model CLI loaded its
  own saved memory of the project. The script now refuses to run without a clean configuration directory.

## Licence

Code: MIT (see `LICENSE`). Text and documentation: CC BY 4.0. No exchange data is included or redistributed.
