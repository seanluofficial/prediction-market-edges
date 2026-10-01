# CROWDED_IDEAS — Kalshi "edges" that off-the-shelf models give an ordinary user

**Purpose.** This is the commonness list for RESEARCH_PROTOCOL.md §6.6. If a hypothesis matches a row here, WHY PERSISTENT has to show the effect has not decayed in the latest period at our size. A match does not kill the hypothesis.

- **Source run:** `research_ideas/crowd_baseline/runs/20260930T2200Z/` (18 answers: 6 prompts x 3 models; prompts in `research_ideas/crowd_baseline/prompts.txt`)
- **Models:** S = Claude Sonnet (`claude -p --model sonnet`); O = Claude Opus (`claude -p --model opus`); X = ChatGPT/Codex (`codex exec`, Codex CLI v0.154.0, model gpt-6-astra, reasoning effort none, web search ON, so it cited live Kalshi help pages). Each ran from an empty temp dir with no repo context.
- **Date:** 2026-09-30 (run stamp 22:00Z)
- **Excluded:** `runs/INVALID_20260930T2155Z_codex_memory_leak`, because Codex's normal home holds project memories that leaked into its answers.
- **Refresh (monthly):** make a directory that holds only a copy of Codex's `auth.json`. Then run `CLEAN_CODEX_HOME=<that dir> bash research_ideas/crowd_baseline/run_baseline.sh`, rebuild this table from the new `runs/<stamp>/`, and update the source line. Never point `CLEAN_CODEX_HOME` at Codex's normal home.
- **Counting rule:** a cluster counts an answer once, however many times the answer mentions it. Mentions that dismiss the idea still count (for example X1: "blindly betting against long shots [doesn't] create an edge"). Each Codex output file prints its answer twice; only one copy was counted. Answer ids: S1-S6, O1-O6 and X1-X6, one per prompt number.
- **Repo status:** found by searching EXPERIMENT_LEDGER.md, the memory index MEMORY.md and closed-hypotheses-index.md (memory folder). Entries name a memory file or a ledger id.

## Idea clusters (sorted by mention count, out of 18)

| id | idea | n | models | category | repo status |
|---|---|---|---|---|---|
| C01 | Fee-aware execution: the taker fee is about 0.07·p(1−p), highest at 50c, so rest limit orders instead of crossing and demand an edge above the fee | 18 | S O X | market-making | KILLED/fee-audit-changed-nothing (mechanics known: kalshi-fees-are-per-series) |
| C02 | Weather settlement mechanics: settle on the NWS CLI for one named station, the climate day runs in local standard time (1am-1am during DST), and station rounding/conversion matters | 15 | S O X | settlement-timing | KILLED/temperature-every-category-closed, daily-temp-trades-after-determination |
| C03 | Read the resolution rules, not the title (source, time zone, ties, announced vs effective); traders who price the headline misprice | 14 | S O X | settlement-timing | KILLED/ledger "B (09-29) title-vs-rules traps" (markets priced the rules) |
| C04 | Weather forecast model: GFS/ECMWF/HRRR/NBM ensembles plus station-bias correction, turned into a distribution across brackets and compared with prices | 14 | S O X | forecasting | KILLED/temperature-forecasting-closed, h08a-nbm-closed, h08a2-noaa-archive-closed |
| C05 | Intra-Kalshi arbitrage: bracket YES asks summing to less than $1 (or bids to more than $1), and non-monotonic "above X" strike ladders | 14 | S O X | arbitrage | KILLED/logical-arb-scan-exchange-wide, zero-fee-ladder-arb-closed, temperature-every-category-closed (0/2396) |
| C06 | Two-sided market making for the spread, with inventory caps, pulling quotes before news, and quoting on fill-conditional probability (X5 #8) | 14 | S O X | market-making | KILLED/passive-mm-verdict, MM15 (09-29), birth-passive-mm-failed; OPEN/mtoxr-pass-at-measured-latency |
| C07 | Favourite-longshot bias: sell 1-15c longshots (buy NO at 85-99c); O2/O4 cite Bürgi, Deng & Whelan (2025) "Makers and Takers" | 12 | S O X | behavioural-bias | KILLED/favourite-longshot-bias-is-real-but-untradeable, NB2 (09-28); OPEN/LS1 (pre-registered, paused) |
| C08 | Near-certain contracts as a yield product: annualise after capital lockup, count interest on collateral, recycle into short-dated 96-99c contracts | 11 | S O X | other | KILLED/carry-is-not-priced-on-kalshi; OPEN/LS1 |
| C09 | Cross-venue arbitrage vs Polymarket, sportsbooks, ForecastEx and CME, with the warning that settlement rules differ | 10 | S O X | arbitrage | KILLED/cross-venue-arb-probe, cross-venue-lfmp-is-venue-local, cross-venue-nonsports-failed-availability, X4b (ledger 09-20) |
| C10 | CPI/jobs nowcast (Cleveland Fed, component models such as gasoline and Manheim, consensus spread) compared with the bracket prices | 9 | S O X | forecasting | KILLED/cpi-market-beats-nowcast (CN1) |
| C11 | Same-day weather nowcast: late in the day the observed METAR/6-h max nearly fixes the high before the market prices it | 9 | S O X | latency | KILLED/hidden-peaks-market-already-knows, metar-latency-race-lost |
| C12 | Fed-decision markets priced from fed funds / SOFR futures (CME FedWatch) | 8 | S O | forecasting | OPEN/ff1-fed-futures-anchor-screen (FF1-H inconclusive); K6 FOMC tails KILLED (09-30) |
| C13 | Sports: de-vigged sharp-book (Pinnacle/Circa) fair value as the anchor; trade when Kalshi lags a line move | 7 | S O X | forecasting | KILLED/sports-pregame-is-at-sharp-book-parity, sports-props-are-calibrated-and-model-loses |
| C14 | Quote to earn Kalshi liquidity-incentive rewards (only O5 builds a strategy on it; the rest say "check what's active") | 7 | S O | rewards-subsidy | KILLED/LF1, subsidised-quotes-are-worse-quotes, ledger 5.2 program yield scan; OPEN/lf2-fx-lip-farming-shadow, lf3-lip-census-running, l2-empty-side-lip-pilot |
| C15 | Fade partisan, fan, hype and celebrity flow (politics, popular teams, viral markets) | 6 | S O | behavioural-bias | KILLED/R5 elections YES (ledger 09-30), sports-pregame-is-at-sharp-book-parity |
| C16 | In-game speed: low-latency live feeds and win-probability models against stale in-play quotes | 5 | S O X | latency | KILLED/inplay-identities-are-bot-arbitraged, in-game-mlb-is-calibrated-after-moves, SG1 (09-28) |
| C17 | Logical consistency across different related events: Fed cut vs rate ladder, title vs conference markets, A⊂B, nested "by date" markets, scenario weights fitted across cities | 5 | S O X | arbitrage | KILLED/f01-exact-payoff-basis-closed, semantic-mismatch-scan-verdict |
| C18 | Model the exact published statistic: first print vs revised vintage, and an unrounded CPI near a rounding boundary | 5 | S O X | forecasting | KILLED/ledger 09-30 "Source-revision family (no volume)"; CN1 |
| C19 | Combo/parlay correlation mispricing: the quoter multiplies legs as if independent | 4 | O X | other | KILLED/SGP-1 (ledger 09-22: asks sit ABOVE the independence product); OPEN/RQ2 census |
| C20 | Fade headline overreaction; buy liquidity-shock drops that related markets do not confirm | 4 | O X | behavioural-bias | KILLED/ladder-prices-have-no-momentum, N1 fade mention jumps, PF1, D5 |
| C21 | Speed at official economic releases and news | 4 | S O | latency | KILLED/close-precedes-publication, early-close-condition-closes-release-edges |
| C22 | Mention markets: read the plural/possessive/transcript rules; prepared remarks released early settle much of the market | 4 | O | settlement-timing | KILLED/mention-markets-yes-bias-is-a-makers-trade, MT1 (09-29), N1 |
| C23 | S&P/Nasdaq range brackets priced from the SPX/SPY options chain (Breeden-Litzenberger) | 4 | S O | forecasting | KILLED/index-hourly-priced-on-realtime-spot (IX1), IX2-L (09-30), hindsight-cap-in-liverule-backtests |
| C24 | ASOS °C→°F rounding artifact: the 5-min display shows a false threshold breach, so buy NO when the 0.1°C METAR groups disagree | 4 | O X | settlement-timing | KILLED/metar-precision-adds-nothing (mechanics: asos-5min-climate-transform, hourly-temp-settlement-is-deterministic) |
| C25 | Fee rounding and fee convexity: size orders under a cent boundary, use one large order rather than many small ones, build payoffs from cheap tail legs | 3 | O | other | KILLED/fee-audit-changed-nothing |
| C26 | Stale books: uneven repricing of adjacent or related contracts, overnight/weekend books, new listings before market makers arrive | 3 | S O X | market-making | KILLED/birth-passive-mm-failed, birth-taker-oracle-failed, XB1 (09-29) |
| C27 | Specialise in thin niche categories (box office, streaming charts, lower-profile sports) | 3 | O X | forecasting | KILLED/PR census (Billboard, Oscar noms, 09-29); OPEN/yt2-official-api-nowcast |
| C28 | Crypto brackets as digital options from Deribit IV, delta-hedged with perps or spot | 3 | S O X | forecasting | KILLED/h6-deribit-anchor-killed, hourly-btc-ladder-is-efficient |
| C29 | Hazard-rate decay in "by date" markets: sell YES on remote events with no catalyst while the price stays flat | 3 | S O | behavioural-bias | OPEN/HZ1 (pre-registered 09-30, pulls after 10-01) |
| C30 | Buy decided-but-unsettled contracts at 96-98c, or rest bids for sellers who want out | 3 | S O X | settlement-timing | KILLED/settlement-delay-gap-does-not-exist, e3-state-collapse-census-closed |
| C31 | Round-number anchoring (5c, 10c, 50c; round strikes) | 2 | S O | behavioural-bias | OPEN/L1 (ledger 09-19: WEAK, shadow only) |
| C32 | Join Kalshi's designated market-maker program for fee reductions and adjusted position limits | 2 | X | rewards-subsidy | UNTESTED (dmm-obligations-unobservable) |
| C33 | Weather dispersion: bimodal front-timing mixtures; buy outer buckets against central ones | 1 | X | forecasting | KILLED/temperature-forecasting-closed |
| C34 | Order-book tells: spoof-like pulled orders, icebergs, queue position as signal | 1 | S | other | KILLED/depth-geometry-adds-nothing |
| C35 | Model the CF Benchmarks averaging window at crypto expiry | 1 | O | settlement-timing | KILLED/crypto-settle-holdout-not-supported-replay-broken (crypto-settlement-window-measured) |
| C36 | Use collateral return on hedged positions for capital efficiency | 1 | X | other | UNTESTED |

Notes: C06 counts S2 because it says "earn the spread rather than paying it". C15 counts O5 #9 ("filter by where the flow comes from"). Hygiene advice appears in almost every answer (trade logs, calibration checks, fractional Kelly, demo API, backtests with fees) and is not an edge, so it is not listed.

## What none of the models said

| check | answers mentioning | detail / quoted phrase |
|---|---|---|
| (a) Kalshi liquidity incentive program / LIP rewards | 7 (S3, S6, O1, O3, O4, O5, O6) | Always generic, for example O5: "Kalshi has run liquidity incentive programs that pay for resting orders near the top of the book"; S3: "pay for resting orders". None gives the payout formula, pool size, share mechanics or program supply. Codex mentions only the DMM program (X4, X6), not LIP. |
| (b) markets left open after the outcome is decided / publication timing vs close | 3 on decided-but-open (S5, O5, X5); 0 on close preceding publication | S5: "After an outcome is effectively known but before settlement ... some participants dump at 97¢". O5: "when the outcome is already publicly known but the market hasn't settled". X5: "Kalshi distinguishes trading close time from determination time and may await official data". None says that close comes before the source publishes, or that markets stay open once an outcome becomes impossible. |
| (c) exact settlement-station / official-count mechanics | Station-level NWS CLI: 15 (see C02); named CLI in 11 files. whitehouse.gov count / Federal Register / other official counts: 0 | O2: "settle on the NWS Daily Climate Report (CLI) for one specific station, such as Central Park (KNYC) or Chicago Midway (KMDW)". X3/X4/X6: "hourly temperature contracts use The Weather Company". Weather station mechanics are crowded. Official-count ladders are not mentioned anywhere. |
| (d) zero maker fees in specific series | 0 name a series; about 10 say maker fees vary in general | O2: "Maker fees are zero or near zero on most markets"; X4: "Maker fees depend on the series; resting orders are not universally free". |
| (e) latency / co-location on 15-minute crypto | 0 | No answer mentions 15-minute markets or co-location. Nearest: S6 "react to data releases in milliseconds" (economics and sports) and O6 on hourly/daily crypto, "speed decides a lot of it". |
| (f) combo/parlay RFQ quoting | 0 as the quoter; 4 mention combo correlation (C19) | O5 treats combos as something to take: "some of the counterparties quoting prices use simple models that treat legs as nearly independent". No answer suggests answering RFQs or mentions the fixed quote size. |
| (g) cross-ladder bracket identities (15-minute vs hourly) | 0 | Nearest are same-horizon identities. O5: "'Above X' contracts should equal the sum of the brackets above X"; X4: "Temperature thresholds against temperature buckets". |

## Summary

1. All three models give the same core list. Fee-aware limit orders (18/18), weather CLI mechanics (15), rule reading (14), weather ensembles (14), bracket/ladder arbitrage (14), market making (14), favourite-longshot (12), near-certain yield (11) and cross-venue arbitrage (10) are all fully crowded.
2. Almost every cluster with 3 or more mentions is already KILLED in this repo. The OPEN ones are C06 (M-TOX-R), C07/C08 (LS1), C12 (FF1), C14 (LF2/LF3/L2), C27 (YT2) and C29 (HZ1), and each needs a §6.6 persistence argument.
3. Weather settlement detail is common knowledge to these models: CLI station, LST day, °C→°F rounding, 6-h METAR max. Codex even knows that hourly temperature settles on The Weather Company.
4. Nothing in the answers covers official-count ladders, close-before-publication, series-specific zero maker fees, 15-minute crypto latency, RFQ quoting or 15-minute vs hourly ladder identities. LIP is named 7 times, but never with its mechanics.
5. The uncrowded ground is exchange mechanics and specific settlement sources beyond weather, not new forecasting ideas.
