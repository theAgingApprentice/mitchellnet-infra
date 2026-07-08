MitchellNET Roadmap — Full Picture
Last updated: 8 July 2026 session. § 4.9 (RC-Experiments time-domain comparison bug) is now RESOLVED and hardware-verified -- Fix #1 and Fix #2 both implemented, test-first, real --bench run confirmed honest RMS/max residual numbers (0.14V RMS / 0.66V max, down from the buggy 2.22V/4.96V). Combined with § 4.7's resolution on 7 July, Experiment 2's --bench workflow is fully working end-to-end for the first time. Andrew now wants to revisit Experiment 2's workflow with three new goals -- DMM R1/C1 measurement timing, a side-by-side real/virtual oscilloscope GUI, and AI-generated analysis of sim-vs-measured differences -- to turn it into a stronger teaching tool for RC circuit theory. See the "Current state as of end of 8 July 2026 session" block at the end of this document for full detail and the exact next-session starting point.

⚠️ READ THIS FIRST NEXT SESSION: Start with the "Current state as of end of 8 July 2026 session" block at the end of this document. First action item (per § 1, now EIGHT+ sessions overdue): rotate the BIS API key. Then: planning discussion for the Experiment 2 workflow revisit -- scope it before writing any code. § 4.7 / § 4.8 / § 4.9 below are now historical record of the (resolved) corruption and time-domain bugs -- still worth reading for the diagnostic methodology and lessons, but both bugs are closed.

Completed
    • ✅ 8 July 2026 session -- RC-Experiments § 4.9 time-domain comparison bug fully resolved and hardware-verified; leftover debug logging removed; experiment README written; numpy/matplotlib dependency documented. RC-Experiments PRs #11-#14 shipped and merged. Hardware-verified via a real --scenario 2 --bench run: RMS residual 0.1372V, max residual 0.6551V (down from the buggy 2.22V/4.96V logged in § 4.9) -- Experiment 2's --bench workflow is now fully working end-to-end for the first time. Andrew has also opened a new workflow-revisit discussion for Experiment 2 (DMM R1/C1 measurement timing, side-by-side real/virtual oscilloscope GUI, AI-generated analysis of sim-vs-measured differences) -- not yet scoped. Full detail in the "Current state as of end of 8 July 2026 session" block at the end of this document.
    • ✅ 7 July 2026 session — § 4.7 dual-channel bench-capture corruption bug fully resolved. Real root cause found (per-channel TRMD acquisition restore during sequential channel captures — not the binary-chunking theory from 6 July, which was a real, correct, but unrelated fix). Three BIS PRs shipped and deployed (chunk_size/timeout tuning + query retry, acquisition-settle delay after timebase reconfiguration, and the actual per-channel-restore fix), plus two RC-Experiments PRs (client-side settle delay, capture-validation layer + mocked and live-hardware test tiers). A new live-hardware pytest tier now exists in both repos so future regressions of this class are caught by `pytest` itself, not just manual scripts. Full detail, all lessons learned, and the new (separate, unrelated, NOT yet fixed) time-domain-alignment bug found immediately after — see § 4.9.
    • ✅ mitchellnet-infra — scripts, runbook, architecture docs
    • ✅ All repos on PR-based workflow with branch protection
    • ✅ bench-instrument-service — Phase 1, Phase 2, and Phase 3 complete (dashboard, bench_client.py, webhooks — 15 June 2026)
    • ✅ ContextVar cross-context bug — fixed & deployed
    • ✅ Fitness tracker extraction — live
    • ✅ Node 24 / checkout@v5 rollout — all repos done
    • ✅ Item 12: aaNewService template + SERVICE-TYPES.md + 4 compose templates — mitchellnet-infra PR #23 (15 June 2026)
    • ✅ Item 13: BIS Phase 3 — dashboard, bench_client.py, webhooks — BIS PRs #12–#16, mitchellnet-infra PR #25 (15 June 2026)
    • ✅ Item 14: Vaultwarden — live at https://vault.mitchellnet.local/ (16 June 2026)
    • ✅ Item 15: Recipes app — fully complete (27 June 2026). PRs #1–#38 shipped. Recipe migration 100% complete. All UCs delivered.
    • ✅ mitchellnet-infra PR #30: Fix aaNewService template backlog items A–F (17 June 2026)
    • ✅ mitchellnet-infra PR #31: docs updated with NGINX multi-prefix exception, url_for warning, HTML template warning (17 June 2026)
    • ✅ InternalWebServer: nginx-routing.md Flask Service Routing Patterns section added (17 June 2026)
    • ✅ InternalWebServer website updates (17 June 2026)
    • ✅ Anthropic API account created (17 June 2026)
    • ✅ RRSP/RRIF Withdrawal Planning — analysis complete, three documents produced (BRD, HLA, financial model — 18 June 2026)
    • ✅ 18 June 2026 session — recipes PR #3 (Claude API import) completed and hardened
    • ✅ 20 June 2026 session — Bare-IP routing & cert parity fixed: mitchellnet-infra PRs #36–#39, InternalWebServer PRs #167–#168
    • ✅ 20 June 2026 evening session — recipes PR #4 (5 of 7 items) + recipe data migration first pass (44 of 48 recipes imported)
    • ✅ 22 June 2026 session — recipes PR #4 item 6 (prep-ahead flag), PR #5 (Cook Log UC-08 + UC-15), PR #5 URL fix. BRD/HLA updated to v1.2.
    • ✅ 23 June 2026 session — recipes PRs #28–#31 all shipped and verified
    • ✅ 26 June 2026 session — recipes PRs #32–#35 + InternalWebServer PR #169 all shipped and verified
    • ✅ 27 June 2026 session:
        ◦ recipes PR #37 — Recipe linking (UC-17). main → ac46e20.
        ◦ recipes PR #38 — Wishlist un-flag prompt (UC-08 enhancement). main → 2245645.
        ◦ recipes BRD and HLA updated to v1.5.
        ◦ Recipe migration 100% complete (2 new URLs imported, 3 duplicates confirmed, 5 Nagi cookbook entries added manually).
        ◦ InternalWebServer re-cloned to standard location: ~/Documents/visualStudioCode/newProjectStructure/InternalWebServer. ✅
        ◦ InternalWebServer PR #170 — Site IA fixes: corrected include paths in reference.html and tools.html, fixed stale links in projects.html, updated about.html (NGINX, removed PII, version 2.1.0). main → 84706a5.
        ◦ AllRecipes 403 known issue — closed, not actioning (recipe permanently discarded).
        ◦ RC-Circuit project (Item 21) added to roadmap.
    • ✅ 28 June 2026 session:
        ◦ InternalWebServer PR #171 — Content reorganisation: Electrical & Workshop card removed from Workspaces; Pilot hole sizes moved to Wood Shop; new Facilities card added to Infrastructure (Electrical Panel Workshop, Sink Maintenance); new Subscriptions card added to Home (Tesla Subscription).
        ◦ InternalWebServer PR #172 — Repo cleanup: 63 stale files deleted (backend, database, recipes, archive, nginx snapshots, monitoring-config, proxy configs, local scripts, orphaned docs).
        ◦ InternalWebServer PR #173 — Deploy workflow fix: stale backend rsync step removed.
        ◦ InternalWebServer PRs #174/#175 — Repo restructure: html/prod/ → site/, workshop/ → workspaces/; workflow, docker-compose, and nav links updated.
        ◦ InternalWebServer PRs #176/#177 — Final cleanup: CLEANUP.md, Makefile, deploy-to-prod.sh, duplicate assets, env banners removed; orphaned pages (reference, tools, projects, site header/footer) deleted; Projects removed from nav.
        ◦ Server cleanup: old html/ directory removed; backend/, database/, all stale .bak and .new orphan files removed from ~/web_server/.
        ◦ mitchellnet-infra runbook and bootstrap.sh verified — no changes needed for fresh rebuild.
        ◦ InternalWebServer — Site IA redesign ✅ COMPLETE.
    • ✅ 4 July 2026 session — RC-Experiments (Item 21) repo created and substantially built:
        ◦ Repo renamed RC-Experiments (was RC-Circuit in the original scoping) — live at https://github.com/theAgingApprentice/RC-Experiments
        ◦ Decision: repo holds many future electronics experiments, one root-level directory each. Experiment 1 = Bias-T circuit (AC/DC separation). Experiment 2 = Series RC (time constant) — built first since the breadboard was already wired.
        ◦ PR #1/#2 — repo scaffold + docs/concepts/ (glossary, circuit-theory, unit-conversions, electricity-fundamentals) + docs/architecture.md, built from Andrew's existing reference docs (RC_Experiment1_Glossary.docx, circuitTheory.odt, electronics_unit_conversion.pdf, roughDraftElectricityGuide.odt, HighLevelExplanationOfSetup.odt)
        ◦ PR #3 — experiment-2-series-rc/docs/theory.md, Fritzing reference design (series-rc.fzz), breadboard photo. Real component values measured via DMM: R1 = 10.42kΩ, C1 = 8.52µF — not the 1kΩ/10µF the old RC_Experiment1 docs assumed (those docs also had an arithmetic error, claiming τ=1s from 1kΩ×10µF, which is actually 0.01s)
        ◦ PR #4 — shared/src/bis_client.py (RCBenchClient), a thin wrapper around BIS's own bench_client.py. Found and worked around a real bug while writing it — see § 4.5 below.
        ◦ PR #5 — experiment-2-series-rc/src/run_experiment.py: full rewrite of RC_Experiment1.py against BIS instead of raw pyvisa/SCPI. QSPICE simulation half carried over almost unchanged; bench control now goes through BIS.
        ◦ Live test of the component-measurement workflow (--remeasure-components) failed: DMM returned OL/overload for R1 and stray-lead capacitance (~100pF) for C1 — not real readings on either component. Root cause not yet found. See Known Issues (§ 6.5).
        ◦ Roadmap updated (this entry).
    • ✅ 5 July 2026 session — BIS § 4.5 gaps closed; RC-Experiments Exp 2 bug resolved:
        ◦ bench-instrument-service PR #21 — Fixed measure()'s default mode ("DCV" → "VOLT:DC") and docstring to match the real MeasurementMode literal; also fixed stale mode="DCV" examples in README.md. Bench-verified via pytest (90 passed). Deployed to production.
        ◦ bench-instrument-service PR #22 — Added remote oscilloscope trigger configuration: configure_trigger()/trigger_status() in oscilloscope_siglent_sds1202xe.py, new TriggerStatus/TriggerConfigRequest models (nested, matching response-side pattern), router wiring in oscilloscope.py. Bench-verified live against the SDS1202X-E (SCPI read/write round-trip confirmed, and confirmed visually on the scope's front panel). All 90 tests pass. Deployed to production.
        ◦ bench-instrument-service PR #23 — Documented the new trigger capability in docs/ARCHITECTURE.md (endpoint table) and docs/BIS_BRD.docx (§6 API Endpoint Summary, two rows). BIS_HLA.docx reviewed — no change needed, it's purely architectural and doesn't describe endpoint-level capabilities. Deployed to production.
        ◦ § 4.5 (BIS feature gaps) is now fully closed. New tech-debt item logged instead — see § 4.6 below.
        ◦ RC-Experiments Experiment 2 component-measurement bug (§ 6.5) — root cause identified: physical bench connection issue (loose/marginal breadboard contact), not a software bug. bench_client.py's measure() modes, and RCBenchClient's _MODE_RESISTANCE ("RES") / _MODE_CAPACITANCE ("CAP") constants, were all verified correct against the real API. Confirmed resolved via three checks: (1) an independent test resistor (~994kΩ) measured correctly via the DMM front panel and via BIS; (2) the original failing resistor (~10.42kΩ), measured in-circuit (not isolated) via BIS, no longer read OL — though the in-circuit reading was ~5% low due to capacitor loading, as expected; (3) same resistor, properly isolated per the script's own instructions, gave a clean 9911.14 Ω. Fresh, trustworthy calibration data captured: R1 ≈ 9911Ω, C1 ≈ 7.0µF, tau ≈ 0.0694s. Known Issues entry (§ 6.5) resolved and removed; see § 4.6 for two smaller gaps found along the way.
        ◦ Roadmap updated (this entry).
    • ✅ 5 July 2026 evening session — BIS oscilloscope coupling bug found, root-caused against real hardware, and fixed; SCPI wire-format test gap closed:
        ◦ Audit-verification script (bench_client.configure_oscilloscope with coupling='DC') revealed that channel coupling silently failed to change on the real SDS1202X-E, while scale and timebase changes worked. Root-caused in two layers, each shipped as its own PR:
        ◦ bench-instrument-service PR #25 — Discovered the nested channel_config/timebase/trigger request-model fix from an earlier, undated session had been built locally (in app/models/oscilloscope.py, app/routers/oscilloscope.py, bench_client.py) but never committed or merged — the running production container had been on the old flat-field request shape the entire time. Committed and shipped that fix, plus a first (still-incorrect) attempt at the coupling fix (bare DC/AC → DC1M/AC1M). Bench-verified via pytest (99 passed) and deployed.
        ◦ bench-instrument-service PR #26 — The DC1M/AC1M fix from PR #25 still didn't work live. Used lxi discover to find the scope's real LAN IP (192.168.2.45 — differs from the placeholder used in some docs) and talked to it directly via a standalone pyvisa script, bypassing BIS entirely, to test candidate CPL command syntaxes. Found the instrument's actual wire format is D1M/A1M/GND, not DC1M/AC1M/GND as the driver's own (incorrect) docstring assumed — meaning the status-read parser (_parse_coupling) had likely been silently misreporting DC as GND for a long time, independent of the write-side bug. Fixed both the write path (configure_channel) and the read path (_parse_coupling). Bench-verified via pytest (99 passed) and against the real scope (coupling now correctly reads back as DC after a DC write). Deployed and confirmed live.
        ◦ bench-instrument-service PR #27 — Closed the underlying test gap: all existing oscilloscope tests mock the driver itself, so none of them actually exercise the SCPI strings sent to write(). Added tests/test_oscilloscope_driver.py (13 new tests) which mocks only the VISA resource one layer down and asserts on literal SCPI strings (e.g. "C1:CPL D1M"). Updated README.md and docs/ARCHITECTURE.md (new "Router-level vs. driver-level instrument tests" section). Bench-verified via pytest (112 passed) and deployed.
        ◦ All three PRs merged and deployed via the standard CI/CD pipeline, verified green in the Actions tab each time — not just the merge-screen badge, per § 7.7.
        ◦ Session hygiene issue found and corrected: aaGitCleanupBranches was run with a typo ("yews") after PR #25's merge, aborting the cleanup and leaving the merged branch checked out locally. Caught before promoting; resolved via git stash → checkout main → pull → delete stale branch → stash pop, no data loss. See § 7.9.
        ◦ BIS API key was pasted in plaintext again this session. Still not rotated.
        ◦ Roadmap updated (this entry).
    • ⚠️ 5 July 2026 late-evening session — RC-Experiments Experiment 2 first real --bench attempt; found and partially fixed a chain of real bugs, but the run itself never fully completed:
        ◦ New terminal channel established: **WINDOWS PARALLELS TERMINAL** (PowerShell), for anything requiring QSPICE (Windows-only) or a full sim+bench run. Requires `$env:BIS_REPO_PATH` and `$env:BIS_API_KEY` set per-session (not persisted).
        ◦ RC-Experiments PR #6 — `configure_scope_for_capture()` added; fixed a stale `points=` arg that never matched real BIS. Committed fresh calibration data.
        ◦ bench-instrument-service PR #28 — Fixed `capture_waveform()`'s `SARA?` query being invalidly channel-prefixed (real instrument hangs indefinitely on `C1:SARA?`; sample rate is global). Added a driver-level wire-format regression test.
        ◦ bench-instrument-service PR #29 — Fixed `bench_client.py`'s stale/wrong `capture_waveform()` docstring to document the real envelope shape (`{"timestamp", "channel_1": <WaveformData>|None, "channel_2": <WaveformData>|None}`).
        ◦ RC-Experiments (left UNCOMMITTED at the time) — updated `run_bench()`'s return statement to match the real envelope shape. This sat as uncommitted work in the working tree until tonight's (6 July) session found and committed it as PR #7 — see below. This is exactly the "invisible uncommitted work" risk § 7.9 warns about, and it recurred even after that lesson was logged.
        ◦ bench-instrument-service PR #30 — Added a stop-acquisition-before-read fix to `capture_waveform()`, believing the scope's AUTO free-run mode was returning truncated data mid-swap. Shipped as best-candidate but flagged unconfirmed.
        ◦ Real, deeper bug found and left unresolved: server logs showed channel 2's first `TRMD?` query came back corrupted as `'C1:WF DAT2,#9000000000\nTRMD AUTO'` — apparently leftover channel-1 binary bytes bleeding into channel 2's query. Hypothesis at the time: `read_raw()` under-reads a large (~7MB) binary block in a single call (classic VISA/socket chunk-size limitation). **This hypothesis was tested and disproven tonight (6 July) — see § 4.7.**
        ◦ Roadmap updated (this entry).
    • ✅ 6 July 2026 late-night session — BIS binary-read chunking fix shipped, tested, deployed (bench-instrument-service PRs #31–#33):
        ◦ bench-instrument-service PR #31 — Added `_read_ieee_block(resource)` to `oscilloscope_siglent_sds1202xe.py`: loops `resource.read_raw()` until the byte count declared in the IEEE-488.2 block header (`#<n-digits><byte-count>`) has actually been received, then slices to exactly that length. Wired into `capture_waveform()` in place of the old single `read_raw()` call. Added 4 new tests to `tests/test_oscilloscope_driver.py` (`TestReadIeeeBlockChunking` ×3, `TestCaptureWaveformHandlesChunkedReads` ×1) — all verified locally against hand-computed byte-math before handing to Andrew. Full suite: 118/118 passed. Merged (PR #31, commit a76fbb0), deployed, Actions tab confirmed green.
        ◦ bench-instrument-service PR #32 — Documented the fix in `docs/ARCHITECTURE.md` under a new "Binary waveform reads and IEEE block chunking" section, placed naturally after the existing "Router-level vs. driver-level instrument tests" section. Merged (commit 45aff68), deployed, Actions confirmed green.
        ◦ **IMPORTANT CAVEAT ON THE ABOVE, discovered later the same night:** a direct pyvisa script run against the real scope (both from the Mac and from inside the running BIS container) showed that a **single** `read_raw()` call already returns the *entire* ~7,000,024-byte block for a 7,000,000-point capture — nothing was ever actually under-read. This means `_read_ieee_block()`'s loop, while correct and safe defensive code, almost certainly **never actually executes more than one iteration** against this real hardware/network path, and was not the fix for the corruption bug after all. The docs added in PR #32 should be treated as accurate-but-not-the-actual-fix — they describe real, sound code, but the causal story ("this fixes the corruption") is not confirmed and is now doubted. See § 4.7 for the full trail. **Next session: add a caveat to this doc section, or soften the causal claim, once the real bug is found.**
        ◦ Re-ran RC-Experiments `--scenario 2 --bench` (attempt #5 by count) with the chunking fix live: failed identically — `ValueError: array of sample points is empty` on `bench["probe_b_time"]` in `compare_and_plot()`. Server logs showed the *exact same* corrupted `TRMD?` response as before deploying the fix, confirming the fix did not change the observed behaviour at all.
        ◦ Investigated further: router code (`app/routers/oscilloscope.py`) already supports a single `/v1/oscilloscope/capture` request handling both channels via `channels: list[int]`, but RC-Experiments' `capture_dual_channel()` was calling `bench_client.capture_waveform()` **twice** — once per channel — each going through `instrument_session()`'s own connect-on-entry/disconnect-on-exit cycle (confirmed by reading `app/dependencies.py`). New hypothesis: the disconnect-then-reconnect boundary between the two channel captures was the actual corruption trigger.
        ◦ bench-instrument-service PR #33 — Added `capture_waveforms(token, channels: list[int])` to `bench_client.py`, issuing one POST with all requested channels instead of one call per channel. Added 2 new tests to `tests/test_bench_client.py`. Full suite 120/120 passed. Merged (commit d22a7c3), deployed, Actions confirmed green (run #74, 9s).
        ◦ RC-Experiments PR #7 — Committed the previously-uncommitted `run_bench()` envelope-shape fix from 5 July late-evening (found via `git diff` before doing anything else in this repo, exactly per the § 7.9 lesson). No CI in this repo. Merged (commit e0c65ce), branch cleaned up.
        ◦ RC-Experiments PR #8 — Changed `capture_dual_channel()` to call the new `capture_waveforms()` once with `channels=[1, 2]` instead of two separate `capture_waveform()` calls. Also added, in the same PR (per Andrew's request): `tests/test_bis_client.py` (4 tests — `configure_square_wave()`'s amplitude/offset math ×2, `capture_dual_channel()`'s single-request composition ×2, all verified against a stub `bench_client.py` in a sandbox before handing to Andrew, then re-verified against the real one — 4/4 passed both times) and `tests/conftest.py` (adds `shared/src` to the import path, defaults `BIS_REPO_PATH` to the sibling `bench-instrument-service` checkout if not already set). Updated `docs/architecture.md` (new paragraph on why `capture_dual_channel()` uses one request, new "Testing" section) and `README.md` (was literally just the title `# RC-Experiments`; now has an overview, environment setup, and test-running instructions). No CI in this repo. Merged (commit 747e7d1), branch cleaned up.
        ◦ Re-ran `--scenario 2 --bench` (attempt #6) with the single-request fix live: **failed identically again.** Server logs confirmed only ONE `POST /v1/oscilloscope/capture` this time (proving the single-request fix genuinely took effect), yet the corrupted `TRMD?` response still appeared — this time reading `'C1:WF DAT2,#9000000000\nTRMD AUTOTRMD AUTO'` (note: "TRMD AUTO" appears **twice**, concatenated — structurally different from the previous two occurrences, which were byte-for-byte identical to each other). This **disproves** the two-separate-connections theory: the corruption now provably happens *within* a single request, between the internal channel-1 and channel-2 capture calls — yet every attempt to reproduce that exact internal sequence in isolation (both on the Mac and inside the actual running Docker container) came back completely clean. See § 4.7 for the full analysis.
        ◦ Extensive live packet-capture diagnosis attempted (tcpdump on the server), documented in full in § 4.7 and § 4.8 — never successfully captured the real waveform transfer despite five attempts, due to a combination of sudo/job-control mistakes, file-permission collisions, wrong assumptions about which port the traffic uses, and unreliable timing coordination across a human-relayed multi-terminal chat workflow. **Root cause of the actual corruption bug is still unknown at end of session.**
        ◦ Session paused at Andrew's request (tired) with the bug still open. Roadmap updated (this entry) with full diagnostic trail preserved for tomorrow.

    1. Passwords / Credentials
Server .env files are source of truth. All credentials also stored in Vaultwarden at https://vault.mitchellnet.local/
Saved in: ~/web_server/.env, ~/services/fitness-tracker/.env, ~/services/recipes/.env

API Keys
    • fitness-tracker API key: ae438be7aee8a379e9ed8840797f9328df729ea3b372966424998159bd3b5ff9
    • BIS API key: 2ecc24bbf4eb7a0f82585fdac5008e99274828fa6b79636fc74e815d19441540
    • recipes API key: 1f2b46825b08159d95f8bb9536e24510b4fd80b0ca10284438a426f1a0072318
    • Anthropic API key (mitchellnet-recipes): saved in Vaultwarden — retrieve from https://vault.mitchellnet.local/
    • fitness-tracker key → ~/services/fitness-tracker/.env
    • BIS key → ~/services/bench-instrument-service/.env
    • recipes key + ANTHROPIC_API_KEY → ~/services/recipes/.env

⚠️ BIS API key rotation is now SIX+ sessions overdue (pasted in plaintext 4 July, 5 July daytime, 5 July evening, 5 July late-evening, and again 6 July late-night — this exact key value has been visible in chat repeatedly). This should be treated as the literal first action item next session, independent of and before continuing the bench-capture bug investigation — it is cheap, safe, well-understood, and has been deferred purely because a more interesting technical puzzle kept taking priority. Do not defer it again.

    2. Secrets Storage
Short term: .env files on the LAN-only server are the source of truth. Long term: Vaultwarden (live at https://vault.mitchellnet.local/). Vaultwarden is fully populated with all credentials including the Anthropic API key. ✅

2.5 Vaultwarden Admin Panel
    • Email: va3wam@gmail.com
    • Master Password: MyVaultwardenPassword$1
    • Hint: Normally caps and dollars are my preferred algorithm
    • Admin token: /VTowpeEmJ76nP8tA/n0au7lfx34RBvLMbf0TAp5FWvFgVqVu5tJ5rCSCrcEr5Qo

2.6 Anthropic Console
    • URL: https://platform.claude.com
    • Login: Google / va3wam@gmail.com
    • Account type: Individual
    • Credits: $5 USD purchased 17 June 2026 (pay-as-you-go — separate from Claude.ai subscription)
    • API key name: mitchellnet-recipes (full key in Vaultwarden)

    3. Full Plan — Current Status
Phase 0 — Security Remediation ✅ COMPLETE
Phase 0.5 — Bare-IP / Name Parity Standard ✅ COMPLETE (20 June 2026)

Feature/Build Work
    • Item 15 (Recipes app) — ✅ COMPLETE. All PRs shipped, recipe migration 100% done.
    • Item 20 (RRSP/RRIF app) — Analysis complete (BRD, HLA, financial model produced 18 June 2026). Build not started. Prerequisite: HLA review against existing MitchellNET stack before any code is written.
    • Item 21 (RC-Experiments, renamed from RC-Circuit) — In progress. The § 4.7 bench-capture corruption bug is RESOLVED (7 July 2026). Now blocked on a separate, new comparison/plotting time-domain-alignment bug found immediately after — see § 4.9.
    • InternalWebServer — ✅ COMPLETE (28 June 2026). All PRs #171–#177 shipped. Repo restructured, cleaned, and site IA redesign done.

Phase 3 — Monitoring: Not yet scoped.
Phase 4 — IoT: Not yet scoped.

    4. aaNewService — Known Issues
Items A–F fixed in mitchellnet-infra PR #30 (17 June 2026). ✅
Checklist updated 20 June 2026 (mitchellnet-infra PR #37) to explicitly name both NGINX vhost files. ✅

    4.5 BIS — Feature Gaps Found via RC-Experiments (4 July 2026) ✅ COMPLETE (5 July 2026)
Found while building RC-Experiments' shared/src/bis_client.py and experiment-2-series-rc/src/run_experiment.py against the real bench_client.py and app/models/multimeter.py. All items below fixed in bench-instrument-service PRs #21–#23 (5 July 2026):
    • ✅ bench_client.py's measure() docstring listed invalid mode strings (DCV, ACV, DCI, ACI, PER). Fixed: default mode and docstring now match the real MeasurementMode Literal (VOLT:DC, VOLT:AC, CURR:DC, CURR:AC, RES, FRES, FREQ, CONT, DIOD, CAP). README.md examples fixed too. (PR #21)
    • ✅ No oscilloscope configuration endpoint existed for trigger settings. Fixed: configure_trigger()/trigger_status() added, new nested TriggerConfigRequest/TriggerStatus models, wired into POST /v1/oscilloscope/configure and GET /v1/oscilloscope/status. Bench-verified live. (PR #22)
    • ✅ docs/ARCHITECTURE.md and BIS_BRD.docx updated to document the trigger capability. (PR #23)
    • "Not Secure" browser badge on /api/bench/docs (§ 6.5) — still open, unrelated to the above.

    4.6 BIS / RC-Experiments — Tech Debt Logged 5 July 2026 (still open, unchanged tonight)
    • BIS — audit request/response model consistency across all four instrument routers (oscilloscope, multimeter, power supply, signal generator). Not urgent.
    • RC-Experiments — no requirements.txt in the repo; run_experiment.py needs numpy and matplotlib, undocumented. Also BIS_REPO_PATH/BIS_API_KEY env vars required but only partially documented — see below, this bit us again tonight.
    • BIS — multimeter, power supply, and signal generator drivers have no driver-level SCPI wire-format tests (the pattern added for the oscilloscope in PR #27). Not urgent, but worth an audit pass.
    • RC-Experiments — the Windows/Parallels VM requires `$env:BIS_REPO_PATH` and `$env:BIS_API_KEY` to be set every fresh PowerShell session (not persisted). RC-Experiments PR #8 (tonight) documented this requirement in README.md, but did NOT fix the underlying lack of persistence — that would need something like a PowerShell profile script or a `.env`-style loader, which does not exist yet. Worth building next time this bites, since it has now bitten on literally every single bench-run attempt across two sessions.

    4.7 ✅ RESOLVED 7 July 2026 (see § 4.9 for root cause and fix) — RC-Experiments dual-channel bench capture corruption (opened 5 July late-evening, extensively investigated 6 July late-night, resolved 7 July late-night). Everything below this line is the historical diagnostic trail from the 5-6 July investigation, preserved as-is — the two theories disproven here were genuinely disproven; the actual root cause is documented in § 4.9, not here.

    Symptom (unchanged across every attempt so far — six-plus and counting):
    `experiment-2-series-rc/src/run_experiment.py --scenario 2 --bench` always fails at the same place:
    `compare_and_plot()` → `np.interp(sim_t, bench["probe_b_time"], bench["probe_b_v"])` → `ValueError: array of sample points is empty`.
    Channel 2's ("probe_b") waveform capture never has data. Channel 1 always appears fine.

    Server-side symptom, every single time: right around the point channel 2's capture begins, a `TRMD?` query (which should return something like `'TRMD AUTO'`) instead comes back corrupted, appearing to contain leftover bytes from channel 1's own binary waveform transfer, e.g.:
    `'C1:WF DAT2,#9000000000\nTRMD AUTO'` (first two occurrences, 5 July late-evening and 6 July early in tonight's session — byte-for-byte IDENTICAL both times, across two different real captures)
    `'C1:WF DAT2,#9000000000\nTRMD AUTOTRMD AUTO'` (third occurrence, later tonight, after the single-request fix — structurally different: "TRMD AUTO" appears twice, concatenated)

    Two real fixes were shipped and deployed tonight, and BOTH were disproven live:

    THEORY 1 (disproven) — "read_raw() under-reads a large binary block in one call, so channel 2's first query catches the tail end of channel 1's un-fully-read response."
    • Fix shipped: bench-instrument-service PR #31 — _read_ieee_block() loops read_raw() until the IEEE header's declared byte count is satisfied.
    • Disproof: a direct pyvisa script (run both from the Mac and from inside the actual running BIS Docker container) showed that a SINGLE read_raw() call already returns the full 7,000,024-byte block for a 7,000,000-point capture, every time, with no under-read at all. The loop in _read_ieee_block() never has anything to loop on operationally, at least at this scope memory depth over this network path. Re-running the experiment with this fix deployed reproduced the IDENTICAL corrupted string as before the fix — strong direct evidence this was never the actual mechanism.

    THEORY 2 (disproven) — "capture_dual_channel() made two separate HTTP requests, each opening and closing its own instrument connection via instrument_session(); the disconnect-then-reconnect boundary between them is what corrupts the second request's first query."
    • Fix shipped: bench-instrument-service PR #33 (capture_waveforms() — one request, both channels) + RC-Experiments PR #8 (capture_dual_channel() updated to use it).
    • Disproof: re-running the experiment with this fix deployed, server logs confirmed only ONE POST /v1/oscilloscope/capture request occurred (proving the fix genuinely took effect — this was not a stale-deploy situation), yet the corrupted TRMD? response still appeared. The corruption is now confirmed to happen WITHIN a single request/single connection, between the internal channel-1 and channel-2 capture calls inside capture() (app/routers/oscilloscope.py) — not between two separate connections.
    • Separately, this exact internal sequence (connect once, capture channel 1 fully, restore trigger mode, then immediately query TRMD? for channel 2 — all on the SAME open connection) was reproduced via a direct pyvisa script THREE times: once on the Mac, once inside the running BIS container reproducing the identical connect/capture/query pattern, and once more with an explicit close()-then-reopen() cycle in between to test the old two-connection theory too. All three came back completely clean — 'TRMD AUTO\n', no corruption whatsoever, every time.

    So: the bug reproduces reliably in the real, live, deployed system (six-plus times, at least three distinct corrupted-string observations), but has NEVER once reproduced in an isolated manual script — on the Mac, or inside the exact same Docker container, using what should be the exact same sequence of SCPI commands over the exact same connection type. This is a genuinely puzzling, environment/timing-dependent bug.

    Additional important, possibly-significant observations, NOT yet investigated:
    • The corrupted string itself looks suspicious as "real leftover binary data." Real leftover ADC bytes (confirmed via manual DMM/pyvisa reads earlier this week) look like random binary junk, e.g. `b'\x00\x01\xff\x00\xff\x00\x00\xff\xff\x00\xff\x00\xff\xff\x00\x00\x00\xff\n\n'` — not clean, readable, structured ASCII text. Yet the "corrupted" string is clean ASCII the whole way through, and its byte-count field reads as `000000000` (all zeros) rather than what a genuine 7,000,000-byte transfer's header would actually encode (`007000000`). The THIRD occurrence's structure (two copies of "TRMD AUTO" concatenated) also looks more like a software/string-handling artifact (e.g. a double-logged or duplicated response string) than raw wire garbage. This raises real doubt about whether this is wire-level corruption at all, versus a bug in BIS's own Python-side logging or response-handling code (e.g. command_logger.py's log_query(), or some interaction with the contextvars-based client-IP tracking under specific timing).
    • DMM cross-check voltage readings during every failed run have been erratic and clearly wrong (expected ~2.5V regardless of frequency; actual readings across attempts: -0.095V, 0.443V, -0.062V, 0.300V, -0.008V, -0.049V, -0.008V, 0.051V). This has not been investigated at all yet and might be a related clue, or might be a separate, unrelated issue (e.g. DMM lead placement, or the DMM measurement genuinely happening at an unfavourable point in the square-wave cycle). Flag for next session — don't assume it's unrelated, but don't assume it's related either.
    • BIS talks to the oscilloscope via VXI-11 over RPC (portmapper on port 111, then a dynamically negotiated port such as 911), NOT a raw socket on port 5025 as originally assumed when planning packet captures. This was confirmed via a successful (if incidentally so) wide packet capture partway through the diagnostic process. All early capture attempts that filtered on `port 5025` were filtering for traffic that structurally never happens — a wasted diagnostic avenue caused by an unverified assumption about the transport. See § 4.8.

    Packet-capture diagnostic attempts (five total tonight) — full blow-by-blow, so tomorrow's session doesn't repeat these mistakes:
    1. First attempt: `sudo tcpdump ... &` — backgrounded immediately, so the password prompt landed on the wrong process; Andrew's password text got interpreted as a shell command. Nothing captured.
    2. Second attempt: `sudo -v` first (cache credentials), then background properly with output redirected to a log file — this part worked, but the capture was filtered to `port 5025` (per the wrong port-5025 assumption above) — 0 packets, because the real traffic never touches that port.
    3. Third attempt: widened to no port filter, but used a fixed ~25 second `timeout` window and asked Andrew to switch terminals and trigger the experiment run manually — 0 packets captured; window almost certainly missed the real traffic because of the human-relayed multi-terminal timing (switching windows, reading/copying output, network round-trip through this chat all eat into a short fixed window unpredictably).
    4. Fourth attempt: same approach, 120 second window instead of 25 — still 0 packets. At this point the "wrong window timing" theory started to look insufficient on its own, and interface/routing was rechecked (confirmed enp4s0f0 is correct; no macvlan networks in play; docker networks are all plain bridge).
    5. Fifth attempt: dropped the timeout entirely, ran tcpdump in the background indefinitely via `nohup ... & disown`, confirmed it was listening, then let Andrew take as long as he needed to run the experiment with zero time pressure — this DID capture 234 packets, and confirmed the VXI-11/RPC transport (port 111 → dynamic port), but the immediate output (piped through `head -60`) hit a broken pipe and got cut off before the actual large transfer; a `wc -l`/`grep`-based follow-up check on the full capture showed 0 packets matching a large-packet-size pattern, and the tail of the capture only showed small (~30-90 byte) periodic exchanges consistent with BIS's own background instrument-registry health-check polling — meaning even this "successful" capture window still didn't actually catch the real, large waveform transfer event. We have NEVER YET actually captured real bytes from an actual failing bench-capture event.
    Conclusion: external packet-capture timed and coordinated across a human-relayed, multi-terminal chat workflow has proven unreliable and should be abandoned as the primary diagnostic method going forward. See § 4.8 and the Next Session Plan below for what to do instead.

    NEXT SESSION PLAN for this bug (in order):
    1. Rotate the BIS API key first (see § 1 above) — unrelated to this bug, but cheap, safe, and badly overdue; do it before diving back into the technical puzzle so it doesn't get deferred yet again by momentum.
    2. Do NOT attempt another externally-timed tcpdump capture as the next diagnostic step — five attempts, zero successful captures of the actual event, not a reliable method in this workflow.
    3. Instead, add TEMPORARY, verbose debug logging directly into the deployed BIS code, specifically:
        a. Inside `_read_ieee_block()`/`capture_waveform()` in `oscilloscope_siglent_sds1202xe.py` — log the exact byte length returned by every individual `read_raw()` call, and how many times the loop actually iterates.
        b. Inside `command_logger.py`'s `log_query()` — log the raw `repr()` of the response BEFORE any string formatting touches it, plus a monotonic counter or timestamp with microsecond precision, so we can tell definitively whether the same query is somehow being logged twice, or whether two different queries' responses are getting interleaved/concatenated in the log output itself (which would point at a logging-layer bug rather than a real wire-level one).
        c. Consider also logging the `contextvars` client-IP value at the exact moment of each log call, given `command_logger.py` uses `contextvars.ContextVar` for client-IP propagation — worth ruling out any cross-context bleed here, especially since this codebase has had at least one prior ContextVar cross-context bug (see "Completed" list, top of doc) — that history makes this a genuinely plausible area to double-check, not just a generic guess.
    4. Deploy that debug patch DIRECTLY, clearly marked as TEMPORARY/DIAGNOSTIC — this does not need to go through the normal one-PR-per-item review process since it's not a real change, just add clear comments marking it as such, run the experiment ONE more time with it live, capture the full BIS logs from that run, then revert/remove the debug logging immediately afterward (either via a quick follow-up commit, or by discarding if not yet committed — confirm which before ending that sub-task).
    5. Only after that gives real evidence should new hypotheses be tested. Do not guess again at the Python/driver layer without a concrete log-based signal pointing at the actual mechanism this time — both prior "fixes" were reasonable, well-tested, correctly-shipped code, and both turned out not to be the actual cause. Confidence from passing unit tests and clean code review is not the same as confidence from live behaviour — this is the same lesson § 7.7 already captured, just re-learned the hard way at a deeper layer.
    6. Once the actual root cause is identified and fixed: re-verify via pytest, deploy, confirm Actions tab green, clean up branches — the normal workflow, unchanged.
    7. Correct the causal claims already written into shipped docs tonight, once the real fix is known:
        - bench-instrument-service `docs/ARCHITECTURE.md`'s new "Binary waveform reads and IEEE block chunking" section (added PR #32) currently implies the loop-based read is "the fix" for the corruption bug. It is real, safe, defensive code, but is very likely NOT the actual fix (see THEORY 1 disproof above). Needs a caveat or softened claim once the true fix is known.
        - RC-Experiments `docs/architecture.md`'s new paragraph (added PR #8) currently says two sequential single-channel captures "were linked to a data-corruption bug" that the single-request fix addresses. This is also now known to be incomplete/likely incorrect as a causal claim (see THEORY 2 disproof above) — the single-request fix is good practice regardless (fewer connections, cleaner code), but did not resolve the corruption. Needs the same correction.
        Both docs are technically accurate about what the code does, just not about why the code was necessary — don't leave this misleading for a future reader (including future-us).
    8. Once the bench run finally succeeds end-to-end (`--scenario 2 --bench`), write `experiment-2-series-rc/README.md` (still not written — waiting on exactly this).
    9. Re-audit whether the DMM cross-check erratic-voltage observation (above) is a related clue or a separate issue — don't assume either way without checking.

    4.8 Wrong Assumptions Made Tonight — Read Before Making New Ones Tomorrow
    This list exists specifically so tomorrow's session doesn't quietly re-adopt an assumption that was already tested and disproven tonight.
    • ❌ WRONG: "A single read_raw() call under-reads a multi-megabyte binary block." Disproven directly against real hardware (Mac and in-container): a single call reliably returns the full ~7MB block. Do not re-adopt this without new evidence.
    • ❌ WRONG: "Two separate HTTP requests (one per channel), each with its own connect/disconnect cycle, is what corrupts the second request." Disproven: single-request fix deployed and confirmed active via server logs (only one POST this run), corruption still occurred.
    • ❌ WRONG (implicitly assumed, never stated outright, but underlying every packet-capture attempt): "BIS talks to the oscilloscope over a raw TCP socket on port 5025." Disproven: real traffic is VXI-11/RPC (portmapper 111 → dynamic port). Any future packet capture must filter by host only, not by port, unless the actual port is re-confirmed first.
    • ❌ WRONG: "A ~20-30 second timed tcpdump window is enough to reliably coordinate with a manually-triggered experiment run relayed through this chat." Wrong four times in a row (25s, 120s, and effectively also the first two attempts once other issues were fixed). Any future packet capture should run indefinitely (no timeout) and be stopped manually only once the run is confirmed complete — and even then, per attempt 5, the real event still wasn't necessarily caught, so packet capture as a method should be deprioritized in favour of in-process debug logging (see § 4.7 next-session plan).
    • ❌ WRONG (a process mistake, not a technical one): I (Claude) wrote a docstring citing "bench-instrument-service PR #33" and "RC-Experiments PR #8" as if they were already-established historical fact, before either PR existed — they were the very PRs being opened. Andrew's VSCode plugin correctly refused to apply this edit and flagged it. Also got the date wrong in the same docstring (wrote "7 July 2026" when it was still 6 July 2026). Lesson: never write forward-looking or unverified references (PR numbers, dates) into shipped code/docs as established fact; double check the actual current date before writing any timestamped comment.
    • ❌ WRONG (earlier in the same session, unrelated to the bench bug): when Andrew's `conversation_search`/`recent_chats` tool calls failed with a service error, I checked Anthropic's public status page, saw everything marked "Operational," and told Andrew there was "no outage" — conflating a coarse, model/API-level public status page with the actual specific internal tool that was failing for me in that moment. The honest answer was "I don't know the status of this specific subsystem, only that the broader public-facing services show green." Lesson: don't collapse two different signals (a specific tool's direct failure vs. a general status page) into one confident claim.
    • Sudo + background jobs: `sudo cmd &` immediately backgrounds the process, which then can't read a password from the terminal (the shell prompt intercepts what you type instead). Correct pattern: `sudo -v` first (caches credentials), THEN background the real command, with output redirected to a log file rather than relying on shell job-control text for status.
    • tcpdump output should never be piped through `head` while tcpdump is still the process writing to that file — doing so caused a "Broken pipe" that killed tcpdump early. Always redirect the read-back (`tcpdump -r file.pcap -nn`) to a separate text file first, then inspect that file with head/tail/grep.
    • A previous capture file can end up owned by the unprivileged `tcpdump` user (after tcpdump drops root privileges internally); a later `sudo tcpdump -w` to the SAME filename can fail with "Permission denied" even though it's run via sudo. Always `sudo rm -f` the old capture file (or use a new filename) before starting a new one.

    4.9 ✅ 7 July 2026 session — § 4.7 corruption bug RESOLVED; new (unrelated) time-domain bug found

    SUMMARY: The dual-channel bench-capture corruption bug left open at the end of the 6 July session is now fully resolved, root cause confirmed, fix deployed and verified on real hardware, and covered by a new permanent live-hardware pytest tier in both repos. Three other real, distinct bugs were found and fixed along the way. Immediately after getting a clean end-to-end run, a fourth, entirely separate bug was found in the comparison/plotting step — this one is new tonight, not part of § 4.7, and is NOT yet fixed.

    ROOT CAUSE OF § 4.7 (finally confirmed): capture_waveform() in the oscilloscope driver ran its own independent TRMD STOP / read / TRMD-restore cycle every time it was called, and the /capture router endpoint called it once per channel. Restoring TRMD to AUTO between channel 1 and channel 2 let the scope resume free-running acquisition, which then got stopped again for channel 2 before a full sweep completed under that resumed state — producing an empty channel 2 capture. Confirmed directly on real hardware: channel 1 returned 7,000,000 real data points, channel 2 returned num_points=0, in the same request. This was NOT the binary-chunking theory from 6 July (that theory was correctly disproven then, and the PR that "fixed" it, while good code, was not the actual cause).

    Three other real bugs found and fixed along the way tonight, each confirmed independently before moving to the next:
    1. Large waveform block transfers can report a placeholder byte_count=0 header (#9000000000) while the real multi-megabyte payload is still being prepared — fixed via explicit chunk_size=500000 and timeout>=10000ms on the VISA resource (this actually was a real, separate, genuine bug from the 6 July chunking theory — both existed).
    2. Individual SCPI queries can time out transiently (~6-7% observed rate in isolated 30-run testing) even after the above fix — fixed via retry-with-backoff (2 retries, 1s apart) in BaseInstrumentDriver.query().
    3. /configure and /capture are separate HTTP requests, each with its own connect/disconnect cycle. Changing the timebase invalidates the scope's in-progress acquisition; a /capture issued immediately after /configure could call TRMD STOP before the first sweep under the new timebase completed, freezing an empty (but structurally valid) buffer. Fixed twice, deliberately: once server-side in BIS's /configure endpoint (time.sleep(scale*14+0.5) after a timebase change, before releasing the connection) and once client-side in RC-Experiments' configure_scope_for_capture() (same formula, independent of whether BIS's own fix is deployed) — belt-and-suspenders, per explicit instruction, after RC-Experiments' side needed to work without depending on further BIS changes mid-session.

    ALL BIS PRs SHIPPED AND DEPLOYED TONIGHT (each individually verified: pytest green, PR merged, CI green, AND the actual "Deploy to Production" GitHub Action run confirmed green — not just the merge-screen badge, per § 7.7):
    • PR #40 — query() retry-with-backoff for transient VISA timeouts; docs/scpi-block-transfer-protocol.md (new); examples/raw_scope_test.py + examples/README.md (new) — standalone, BIS-independent diagnostic script, now the canonical reference implementation for this class of diagnosis.
    • PR #41 — acquisition settle delay in /configure after a timebase change (time.sleep(scale*14+0.5)); docs updated.
    • PR #42 — THE ACTUAL FIX: capture_waveforms(channels: list[int]) added to the driver (single stop/read-all/restore cycle instead of one cycle per channel); /capture router updated to call it once instead of looping capture_waveform() per channel; capture_waveform() now delegates to it for the single-channel case. New live-hardware pytest tier added (tests/test_oscilloscope_hardware.py, gated behind BIS_HARDWARE_TESTS=1) with three regression tests, one per bug above — all three ran and passed against the real, powered-on scope before merging.

    ALL RC-EXPERIMENTS PRs SHIPPED TONIGHT (no CI/deploy pipeline in this repo — verified via pytest only, per repo's existing pattern):
    • PR #9 — docs/architecture.md updated to record the (at-the-time-believed) BIS fix; removed a stale, superseded copy of the early raw_scope_test.py draft (canonical version now lives only in BIS's examples/).
    • PR #10 — the big one: shared/src/capture_validation.py (new) — validate_capture() raises specific exceptions (EmptyCaptureError, PartialCaptureError, ChannelMismatchError, ImplausibleVoltageError) the instant a malformed capture is detected, instead of letting it silently reach np.interp() three calls later as a generic numpy ValueError. Wired into run_bench() immediately after capture_dual_channel(). Client-side settle delay added to configure_scope_for_capture(). Full test-first build: tests/test_capture_validation.py (6 cases, each reproducing a real or realistic failure shape) written and confirmed failing (import error) BEFORE the module existed; tests/test_run_bench.py (3 cases) exercises the real run_bench() end-to-end with RCBenchClient mocked, proving the validation is actually wired in, not just unit-tested in isolation; tests/test_hardware_integration.py (3 cases, gated behind RC_HARDWARE_TESTS=1) talks to the real BIS instance and real bench — this is the tier that actually caught the still-open bug live, including one test (test_real_capture_both_channels_have_matching_metadata) that was deliberately written to FAIL until the BIS fix landed, then re-run after PR #42 deployed to confirm it now passes. docs/testing.md (new) documents the full two-tier test strategy and why mocked tests alone could not and did not catch either real bug this week.

    HOW THE ACTUAL ROOT CAUSE WAS FOUND (methodology worth repeating): after two real BIS fixes (chunking, settle delay) still didn't produce a working end-to-end run, Andrew explicitly and firmly redirected away from further BIS guessing and toward a strict test-first approach in RC-Experiments — see § 4.8-style "lessons" below, this is the single most important process lesson from tonight. A minimal, standalone, BIS-independent pyvisa script (examples/raw_scope_test.py, run manually first, then formalized into BIS's example scripts) was used to get 30 consecutive clean dual-channel captures directly against the scope, which proved the low-level wire protocol was NOT the remaining problem — the bug had to be in how the real driver/router sequenced multiple channels, which a from-scratch script naturally didn't reproduce because it was written to stop once and read both channels together. Comparing that working script's structure line-by-line against the real driver's actual capture_waveform()-called-twice pattern is what surfaced the per-channel TRMD restore as the structural difference. Lesson: a diagnostic script that behaves DIFFERENTLY from the real code path under test can pass 30/30 and still tell you nothing about the real bug — the diagnostic must reproduce the real code's actual sequencing, not just its final wire format, or write a test that exercises the real code path directly (which is exactly what tests/test_oscilloscope_hardware.py now does, going forward).

    NEW BUG FOUND — NOT YET FIXED, SEPARATE FROM § 4.7: with both real fixes deployed, --scenario 2 --bench finally completed successfully end-to-end for the first time ever (no crash, capture_validation passed, comparison plot generated). But the plot (RC_Experiment2_S2_comparison.png) shows the RMS/max residual numbers are badly inflated (RMS 2.22V, max 4.96V) — NOT because the measurement is bad, but because of a real, separate bug in compare_and_plot(): the scope's captured time_array is centered on the trigger event (spans roughly -3.5s to +3.5s, confirmed via diagnostic prints), while the simulated sim_t comes straight from parse_qraw() and spans 0 to sim_duration (6s for scenario 2, per the .tran directive in build_netlist() and the PULSE source both starting at t=0). np.interp(sim_t, bench["probe_b_time"], bench["probe_b_v"]) silently extrapolates (holds the last real sample flat) for every sim_t point outside the real [-3.5, 3.5] window — visibly confirmed in the plot as a clean, accurate overlay from roughly t=0 to t=3.5s (residual near zero, real RC curve shape matches simulation closely) followed by a sudden runaway to ~5V residual exactly where the real data runs out. The underlying measurement and both circuit-level fixes are good; this is purely a comparison/plotting bug.

    NEXT SESSION — START HERE:
    Two fixes proposed, not yet built, not yet discussed for priority beyond being named:
    Fix #1 (minimum, makes the reported numbers honest): restrict the interpolation/residual calculation in compare_and_plot() to only the sim_t values that actually fall inside bench["probe_b_time"]'s real min/max range, instead of the full 0-6s sim_t array. Small, low-risk, immediately fixes the RMS/max residual numbers and the runaway plot tail.
    Fix #2 (more correct, more work): explicitly align the simulation's time origin (source turn-on at t=0) with the scope's time origin (centered on its own trigger event, which is not guaranteed to be phase-aligned with the simulated source's t=0) — e.g. by finding the first rising edge in both datasets and shifting one time axis so they share a common zero point, rather than relying on the two axes visually lining up by chance (which they currently do for scenario 2's 1Hz signal, but that is not guaranteed for other frequencies/scenarios).
    Awaiting Andrew's go-ahead on scope: Fix #1 only tonight (fast, immediately actionable), or Fix #1 + Fix #2 together (more correct long-term). Once decided: same test-first process as tonight (write a failing test reproducing the exact time-domain mismatch shown in RC_Experiment2_S2_comparison.png, confirm it fails, then implement), same one-repo-at-a-time PR process, same hardware-verification step before calling it done.

    BACKLOG ITEMS LOGGED TONIGHT (not urgent, explicitly deferred, do not lose track of these):
    • capture_validation.py's ImplausibleVoltageError check does a per-element Python float() loop over voltage_array (potentially 7,000,000 elements) — should use numpy min/max instead of a Python-level loop once performance is measured as an actual problem, not before.
    • tests/test_run_bench.py loads run_experiment.py fresh via importlib.util.spec_from_file_location() in every single test function (re-executing the whole module each time) rather than caching the loaded module — correct but slower than necessary; could be cached at fixture scope.
    • tests/test_oscilloscope_hardware.py's test_real_large_single_channel_capture_completes_without_corruption asserts num_points > 1_000_000, which bakes in an assumption about scenario 2's specific timebase/memory-depth configuration into a supposedly general regression test — worth a comment noting the assumption, or parametrizing, if this test ever needs to run against a different capture configuration.
    • README-documented invocation gotcha (not a bug): RC-Experiments' tests must be run via `python -m pytest` (not bare `pytest`) from the repo root, or the `shared.src.capture_validation` import fails with ModuleNotFoundError — bare pytest doesn't add the repo root to sys.path the way `python -m pytest` does. Worth a one-line README note; not yet added.
    • DMM cross-check step in run_bench() — Andrew explicitly said tonight this reading is not useful to the experiment's actual goal (SDG + SDS only) and should not be a focus. Not removed from the code yet — still present, still printed, just no longer a diagnostic priority. Consider removing it from run_bench() entirely in a future cleanup pass rather than continuing to carry it as dead weight; explicitly deprioritized, not forgotten.
    • BIS — multimeter/power-supply/signal-generator drivers still lack the driver-level SCPI wire-format test pattern and live-hardware test tier that oscilloscope now has (§ 4.6, unchanged tonight, still open).
    • BIS — request/response model nesting inconsistency across the four instrument routers — still unaudited (§ 4.6, unchanged tonight).
    • BIS API key rotation — still not done. Now SEVEN+ sessions running with the key pasted in plaintext in chat (4 July, 5 July ×3, 6 July, 7 July). This is cheap and should really happen before the next debugging session gets underway, per § 1.

    KEY PROCESS LESSON FROM TONIGHT, WORTH CARRYING FORWARD EXPLICITLY: two consecutive real, correctly-tested, correctly-deployed BIS fixes (chunking loop protection, then acquisition-settle delay) each individually verified via green CI and a real hardware smoke test, still did not add up to a working end-to-end experiment run — because passing mocked/isolated tests proved the code did what it was written to do, not that it did the right thing under the real, full call sequence a real client actually uses. The fix was not "test harder" in the abstract, it was specifically: write tests that exercise the real production code path (not a hand-rolled reimplementation of it) against real hardware, and treat a currently-failing real-hardware test as a legitimate, valuable, INTENTIONAL part of the suite until the underlying bug is actually fixed — not something to suppress, delete, or quietly work around. This is now a standing practice in both repos going forward (see tests/test_oscilloscope_hardware.py's and tests/test_hardware_integration.py's module docstrings, which state this explicitly for future sessions).

    5. Recipes App — Remaining Work
    • Recipe-level rating system — deferred pending CookLog usage review
    • Recipe file upload 413 fix — low priority (client_max_body_size in both NGINX vhosts + Flask MAX_CONTENT_LENGTH)
    • GitHub Actions deprecation annotation (actions/setup-python@v5 / Node.js 20) — low priority, flagged for mitchellnet-infra maintenance pass
    • Full browser functional test of AI meal planning flow — not yet done (Andrew to test suggest → review → accept/reject → meal plan populated)

    5.5 Recipes App — DB Backup ✅ COMPLETE (26 June 2026)
Nightly cron job running on server. Script: ~/backups/recipes/backup_recipes_db.sh. Dumps to ~/backups/recipes/recipes_db_YYYY-MM-DD.sql. Retains last 3. Log: ~/backups/recipes/backup.log. Confirmed: 3 consecutive successful runs. Restore procedure documented in runbook.md.

    6. RRSP/RRIF Withdrawal Planning App — Item 20
Planning and analysis complete. Three documents produced (BRD, HLA, financial model). Build not yet started.
Outstanding prerequisite: HLA review against existing MitchellNET stack (service type, NGINX routing, CI/CD pattern) before any code is written.

    6.5 Known Issues — Logged, Not Yet Actioned
    • "Not Secure" browser badge on https://192.168.2.10/api/bench/docs despite a valid, trusted cert — root cause not identified. Low priority, functionality unaffected.
    • GitHub Actions deprecation annotation: "Node.js 20 is deprecated... actions/setup-python@v5" — not a failure. Flagged for mitchellnet-infra maintenance pass.
    • Recipe file import fails with 413 Request Entity Too Large above ~1MB. Workaround: rasterize large PDFs to compressed JPEG.
    • InsanelyGoodRecipes.com import (https://insanelygoodrecipes.com/vietnamese-recipes/) may be a category page not a single recipe — Andrew to check the saved recipe's detail page.
    • No UPS installed on the server — open follow-up from the 18→19 June power-loss reboot.
    • AI meal planning — full browser functional test not yet done (Andrew to test end-to-end flow).
    • BIS API key pasted in plaintext repeatedly (4 July, 5 July ×3, 6 July) — SIX+ sessions now. Rotate ASAP — see § 1.
    • ✅ RESOLVED 7 July 2026 — RC-Experiments dual-channel bench-capture corruption bug — see § 4.9 for full detail and root cause.
    • DEPRIORITIZED 7 July 2026 — DMM cross-check voltage readings during bench captures were erratic across every attempt; Andrew has explicitly stated this reading is not useful to the experiment's actual goal and is not a debugging priority going forward. Still present in run_bench() but no longer investigated. See § 4.9 backlog.
    • RESOLVED 8 July 2026 -- RC-Experiments comparison/plotting time-domain misalignment bug -- see § 4.9 for the original diagnosis and the "Current state as of end of 8 July 2026 session" block at the end of this document for the fix and hardware verification.

    7. Lessons Learned — NGINX + Flask Routing
At the start of any new session involving Flask services or NGINX routing, request these two documents before writing any code:
    • recipes/README.md — Development Notes section
    • InternalWebServer/docs/nginx-routing.md — Flask Service Routing Patterns section

Summary of key rules
    • Approach A: trailing slash on proxy_pass strips the prefix — Flask routes use simple paths
    • Multi-prefix exception: secondary prefixes use proxy_pass without trailing slash to preserve the full path
    • url_for() is prefix-unaware: always use hard-coded absolute paths for redirects
    • HTML anchor tags only: Jinja2 templates must use <a> tags
    • Bare-IP parity: every service location block must be added to BOTH nginx/conf.d/prod.conf AND nginx/conf.d/000-bareip.conf — exception: subdomain-based services (currently only Vaultwarden)
    • Template action= and href= values must include the /recipes/ prefix — always smoke-test new routes with curl -sk immediately after deploy
    • Always verify a live record exists before using its ID in curl smoke tests
    • Picklist dropdowns in templates must use object.name (e.g. {{ c.name }}) when the list comes from a DB query returning model objects

7.5 Lessons Learned — Claude API Integration
    • max_tokens must be generous: use 4096 as a baseline for structured extraction tasks
    • Don't share Claude API call functions across services with different system prompts
    • curl smoke tests on the server need -k flag (self-signed cert)
    • VSCode Claude plugin can silently mangle large file overwrites — verify with wc -l and head/tail

7.6 Lessons Learned — Documentation & Process
    • A documented warning doesn't prevent a mistake — the durable fix is updating tooling, not re-stating the warning
    • When a doc claims to be a complete reference, verify against live files (cat / diff)
    • Pasted terminal output can introduce copy/paste artifacts — verify with direct file read before assuming the file is broken
    • DB changes must go through the repo (init.sql + models), not directly on the server
    • The live DB does not automatically pick up new CREATE TABLE IF NOT EXISTS statements on redeploy when the DB container already exists — apply new tables via docker exec after the first deploy

7.7 Lessons Learned — One-Item-Per-PR Workflow & Live Verification
    • Split multi-item scoped work into one PR per item — keeps diffs small and reviewable
    • GitHub merge screen "X checks pending" badge lags behind actual Actions run — check Actions tab directly
    • Code-review-confidence and live-behavior-confidence are different things — always live-test features with actual data
    • (Reinforced hard tonight) — a fix can pass every unit test, get bench-verified in a narrow isolated sense, get deployed cleanly, and STILL not be the actual fix for the live bug it was written for. Passing tests prove the code does what you wrote it to do; they don't prove your theory of the bug was correct. Two such fixes shipped tonight; neither resolved the actual issue.

7.8 Lessons Learned — Workflow Discipline
    • Always use aaGitPromote to create feature branches — never commit directly to a feature branch or push manually, as this bypasses the PR trigger and the deploy workflow will not fire
    • After any edit that needs fixing, do NOT push manually to the open branch — instead open a new PR from that branch via GitHub UI so the deploy fires on merge
    • Stay on main branch in all terminals at all times between PRs — aaGitPromote creates the feature branch itself
    • When a deploy workflow fails, read the full error before actioning — the failing step name and error message identify the exact fix needed

7.9 Lessons Learned — Hardware SCPI Verification & Session Hygiene (5 July 2026)
    • Never trust a driver's own docstring/comments for real instrument wire-format syntax — verify directly against the physical instrument.
    • lxi discover (from lxi-tools, brew install lxi-tools) is the fast way to find an LXI/VXI-11 instrument's LAN IP when it's not documented or has changed.
    • A test suite that only mocks the driver (router-level tests) cannot catch bugs in the actual commands a driver sends to hardware. If a service talks to real instruments/hardware over a wire protocol, at least one test file per driver should mock only the transport layer and assert on literal wire strings.
    • Uncommitted local work-in-progress left at the end of a session is a real risk — end every session by either committing/promoting real fixes or explicitly logging them as "not yet committed." (This recurred tonight: the 5 July late-evening run_bench() envelope fix sat uncommitted until tonight's session found it via git diff before starting any new work — the process worked as designed, but only because the next session's first move was checking git status/diff before touching anything, per the INSTRUCTION FORMAT rules below. Keep doing this.)
    • Branch cleanup (aaGitCleanupBranches) should run immediately after every merge, before any further verification or new work — not deferred.
    • When giving Claude Mac-terminal instructions to inspect changes, ask for the exact command to run, not just "give me a diff."

7.10 Lessons Learned — Live Diagnostic Sessions & Multi-Terminal Coordination (6 July 2026, new tonight)
    • When a fix is built on an untested theory of a bug's root cause, treat the theory as unconfirmed until the fix is verified against a live re-run of the ORIGINAL failure — not just against unit tests. Tonight, two separate fixes (chunking loop, single-request capture) both passed every test written for them and both failed to resolve the live bug, because the underlying theory of causation was wrong both times, not the code.
    • Before spending time on external diagnostics (packet capture, etc.), verify the basic transport assumption first (what protocol, what port) — we spent multiple attempts filtering tcpdump on port 5025 before confirming the real traffic is VXI-11/RPC on a dynamically-negotiated port. A five-minute `ip route get` + one wide, unfiltered capture would have surfaced this immediately.
    • Externally-timed diagnostics (e.g. "start a capture, then go run this in another terminal") are unreliable when coordinated through a human relaying output between two terminals and a chat interface — there is no way to guarantee the timing window is met. Prefer diagnostics that don't depend on timing at all: in-process debug logging that captures everything about a run automatically, rather than an external observer trying to catch a narrow window from outside.
    • sudo + shell job-control pitfalls (documented in § 4.8) cost real time tonight and are avoidable with `sudo -v` first, always redirecting backgrounded output to a file, and never piping a live capture through `head`.
    • When a person is audibly frustrated (including swearing) but is not in any distress beyond task frustration, the right response is to keep working the actual problem calmly and competently — not to comment on the tone, not to get defensive, and not to slow down. Andrew's frustration tonight was squarely about the technical problem taking too long, not about needing support — the correct response was exactly what happened: acknowledge briefly, then execute the requested action immediately.

    8. InternalWebServer — Site Structure
Navigation: Home | Engineering | Workspaces | Infrastructure | About

Repo structure (as of 28 June 2026):
    • site/ — all served HTML, CSS, JS, images, and reference PDFs (replaces html/prod/)
    • site/workspaces/ — Workspaces hub (replaces workshop/)
    • site/engineering/ — Engineering hub
    • site/infrastructure/ — Infrastructure hub
    • includes/ — shared header and footer fragments
    • nginx/ — NGINX config (prod.conf, 000-bareip.conf, ssl-params, security-headers)
    • docs/ — nginx-routing.md and other repo documentation
    • sslCertificates/ — CA cert and renewal instructions (private keys NOT in repo)

Hosted Apps
    • /fitness/ — Fitness Tracker
    • /recipes/ — Recipes app (Flask + MariaDB) ✅ Complete
    • /rrsp/ — RRSP/RRIF Withdrawal Planning app (planned — Item 20)

Infrastructure → Hosted Services
    • Vaultwarden — https://vault.mitchellnet.local/

    8.5 InternalWebServer — Backlog / Maintenance
    1. Re-clone to standard location ✅ COMPLETE (27 June 2026) — now at ~/Documents/visualStudioCode/newProjectStructure/InternalWebServer
    2. Site IA fixes ✅ COMPLETE (27 June 2026) — PR #170
    3. Site IA redesign ✅ COMPLETE (28 June 2026) — PRs #171–#177

    9. RC-Experiments — Item 21 (renamed from RC-Circuit, in progress, BLOCKED)

    Overview
    A repo of electronics-learning experiments, each comparing simulated (QSPICE) circuit behaviour against live bench instrument measurements (via BIS) and explaining the result against theory.

    Key facts
    • Repo: https://github.com/theAgingApprentice/RC-Experiments (live, private)
    • Dev environment: Mac Studio (macOS) — code developed and edited on Mac, in VSCode with the Claude plugin
    • Run environment: Windows OS running under Parallels Desktop on the same Mac Studio (QSPICE is Windows-only) — the `Z:\` drive there is a Parallels *shared folder* pointing at the same Mac filesystem, not a separate clone, so no separate git pull is ever needed on the Windows side once the Mac side is updated
    • Depends on: bench-instrument-service (BIS) — live instrument readings via the BIS API, wrapped by shared/src/bis_client.py (RCBenchClient)
    • BIS talks to the physical oscilloscope over VXI-11/RPC (portmapper port 111, then a dynamically negotiated port) — NOT a raw socket on port 5025. Important if anyone attempts packet-level diagnostics again.

    Repo structure
    docs/ (concepts/ + architecture.md) — shared across every experiment
    shared/src/ — RCBenchClient (BIS wrapper) + as of tonight, tests/ (test_bis_client.py, conftest.py)
    experiment-1-bias-t/ — not yet built
    experiment-2-series-rc/ — built, blocked from running end-to-end by § 4.7's bug

    What each experiment does
    1. Run a QSPICE simulation of the circuit
    2. Read live measurements from real bench instruments via BIS
    3. Compare simulated results against live instrument readings
    4. (Planned, not yet built) Call Claude API for plain-English analysis

    Experiment 2 — Series RC — status
    • Theory, Fritzing reference design, and run script all built (PRs #3–#5)
    • Component-measurement bug (5 July) — resolved, was a physical bench issue.
    • Fresh, trustworthy measured values (5 July, properly isolated): R1 ≈ 9911Ω, C1 ≈ 7.0µF, τ ≈ 0.0694s
    • `capture_dual_channel()` now issues a single BIS request (PR #8, tonight) instead of two — good practice, kept, but did NOT resolve the bench-capture bug (§ 4.7)
    • `run_bench()`'s envelope-shape handling fixed and committed tonight (PR #7) — matches BIS's real response shape correctly; this part of the pipeline is confirmed working (channel 1 data always comes through fine)
    • `tests/test_bis_client.py` + `tests/conftest.py` added tonight (PR #8) — 4 tests covering `configure_square_wave()`'s amplitude/offset math and `capture_dual_channel()`'s request composition. All passing. Does NOT and cannot test the actual bench-capture bug, since that only manifests against real, live hardware under conditions not yet reproduced in isolation.
    • README.md written tonight (was previously just the title) — overview, environment setup (BIS_REPO_PATH), and test-running instructions.
    • **`--bench` run has still never completed successfully end-to-end — six-plus attempts, all failing identically at the channel-2 capture step. See § 4.7 for the full diagnostic trail and next-session plan.**
    • `experiment-2-series-rc/README.md` (the experiment-specific one, distinct from the repo-root README.md above) -- written 8 July 2026 (RC-Experiments PR #13).

    Experiment 1 — Bias-T — status
    • Not yet started.

    Status: 🟢 Experiment 2 fully working end-to-end as of 8 July 2026 -- § 4.7 (bench-capture corruption) and § 4.9 (time-domain comparison alignment) both resolved and hardware-verified. Andrew has opened a new workflow-revisit discussion (DMM R1/C1 measurement timing, side-by-side real/virtual oscilloscope GUI, AI-generated difference analysis) -- see the "Current state as of end of 8 July 2026 session" block at the end of this document. Experiment 1 not started.

    10. Resume Prompt (paste this verbatim to start the next session)

Resuming MitchellNET work.

Workflow rules — read these carefully and follow them for every instruction in this session:

INSTRUCTION FORMAT: Every instruction you give me must clearly state one of the following at the start:
    • SERVER TERMINAL — command to run via SSH on andrew@192.168.2.10
    • DEV MAC TERMINAL — command to run in the terminal on my Mac Studio (state which repo directory I should be in and confirm I am on the main branch)
    • VSCODE CLAUDE PLUGIN — instruction to give to the Claude plugin in VSCode (state which repo window and which branch)
    • WINDOWS PARALLELS TERMINAL — PowerShell command, for anything requiring QSPICE or a full sim+bench run; remember `$env:BIS_REPO_PATH` and `$env:BIS_API_KEY` are NOT persisted across sessions and must be re-set at the start of every fresh PowerShell session
Never mix instructions for two repos in a single step. Never give a VSCode instruction without naming the repo and branch first.

ONE REPO AT A TIME: I have separate VSCode windows per repo. Always complete all work in one repo before switching to another.

COMMAND RULES:
    • Always pipe git diff through cat: git diff | cat
    • Always get a diff before promoting: after any edit, run git diff | cat and paste back for review
    • Always give me the exact command to run — say "run this command," not "give me a diff" or other indirect phrasing
    • Stay on main branch in all terminals at all times — aaGitPromote creates the feature branch itself
    • For file contents, give me raw cat/grep commands to run in the terminal rather than asking the VSCode plugin to "show" files
    • Promote via: aaGitPromote <branch-name> "<commit message>" (run from main in the repo terminal)
    • Clean up via: aaGitCleanupBranches (after PR is merged in GitHub UI) — run this immediately after every merge, before any further verification or new work, not deferred
    • Never click "Delete branch" in GitHub UI — the cleanup script handles it
    • Type cleanup confirmations ("yes") carefully — a typo aborts the cleanup and leaves a stale branch checked out
    • sudo + background jobs: always `sudo -v` first to cache credentials BEFORE backgrounding any sudo command; always redirect backgrounded output to a log file; never pipe a live/in-progress tcpdump read-back through `head` — write to a file first, then inspect the file
    • Before writing any timestamped comment/docstring/PR reference into code, double-check the actual current date, and never cite a PR number or reference as "already merged" if it's the PR currently being opened

PR WORKFLOW:
    • I open and merge PRs via GitHub UI after CI passes
    • After merge, always check the Actions tab for "Deploy to Production" directly — don't rely on the GitHub merge screen's check-status badge
    • A green Actions run and a passing test suite prove the code does what it was written to do — they do NOT prove the underlying theory of a bug's cause was correct. Verify against a live re-run of the original failure before declaring a bug fixed.

DB CHANGES: Never make DB changes directly on the server. All schema changes go through init.sql and models in the repo, deployed via CI/CD.
NOTE: The live DB does not automatically pick up new CREATE TABLE IF NOT EXISTS statements on redeploy when the DB container already exists. Apply new tables via docker exec after the first deploy.

FLASK + NGINX: At the start of any session involving Flask services or NGINX routing, request these two docs before writing any code:
    • recipes/README.md — Development Notes section
    • InternalWebServer/docs/nginx-routing.md — Flask Service Routing Patterns section


Current state as of end of 6 July 2026 late-night session:

COMPLETED THIS SESSION (6 July late-night):
    • bench-instrument-service PR #31 — _read_ieee_block() chunking loop added to capture_waveform(), 4 new tests, 118/118 passed, deployed, verified green. (Later shown likely NOT to be the actual fix — see § 4.7.)
    • bench-instrument-service PR #32 — documented the above in docs/ARCHITECTURE.md, deployed, verified green. (Causal claim now doubted — needs correction once real fix known.)
    • bench-instrument-service PR #33 — capture_waveforms() added to bench_client.py for single-request multi-channel capture, 2 new tests, 120/120 passed, deployed, verified green.
    • RC-Experiments PR #7 — committed the previously-uncommitted run_bench() envelope-shape fix from 5 July late-evening (found via git status/diff at start of session, per § 7.9).
    • RC-Experiments PR #8 — capture_dual_channel() switched to single-request capture_waveforms(); added tests/test_bis_client.py + tests/conftest.py (4 tests, all passing); updated docs/architecture.md and README.md.
    • Re-ran the bench experiment three more times tonight (attempts #5, #6, #7 by rough count) with each fix live in turn — all failed identically or near-identically. Confirmed via server logs that both fixes genuinely took effect (single read_raw() call sufficed even before the loop could matter; only one POST request occurred after the single-request fix) — the corruption persisted regardless, disproving both working theories.
    • Extensive live packet-capture diagnostics attempted (5 separate tcpdump attempts) — never successfully captured the actual large waveform transfer event; confirmed BIS uses VXI-11/RPC (port 111 → dynamic port) rather than raw port 5025; documented every mistake made (sudo/job-control, file permissions, timing) in § 4.8 so they aren't repeated.
    • Root cause of the actual corruption bug is STILL UNKNOWN. Leading untested theory: the "corruption" may be a logging/string-handling artifact in BIS's own Python code (command_logger.py or similar) rather than genuine wire-level data corruption — based on the corrupted string looking like clean, structured ASCII rather than random binary junk, and one occurrence showing an oddly-duplicated "TRMD AUTO" substring.
    • Session paused at Andrew's request (tired), bug still open. Roadmap updated (this entry) with full diagnostic trail preserved.

ACTIVE PROJECTS / NEXT SESSION OPTIONS, IN ORDER:
    1. ⚠️ FIRST — rotate the BIS API key. Six-plus sessions overdue, cheap and safe, unrelated to the bug, do it before anything else.
    2. ⚠️ TOP TECHNICAL PRIORITY — diagnose the RC-Experiments dual-channel bench-capture corruption bug (§ 4.7) via TEMPORARY debug logging added directly to the deployed BIS code (capture_waveform()/_read_ieee_block() and command_logger.py) — NOT via further external packet capture, which has failed five times running. Full plan in § 4.7's "NEXT SESSION PLAN" subsection.
    3. Once the real root cause is found and fixed, correct the causal claims in the docs shipped tonight (bench-instrument-service docs/ARCHITECTURE.md § "Binary waveform reads and IEEE block chunking"; RC-Experiments docs/architecture.md's capture_dual_channel() paragraph) — both currently overclaim that the shipped fixes resolved the bug.
    4. Once a --bench run succeeds end-to-end, write experiment-2-series-rc/README.md.
    5. Investigate whether the erratic DMM cross-check voltage readings (§ 4.7) are related to the main bug or a separate issue.
    6. Item 21 — RC-Experiments, Experiment 1 (Bias-T): not started.
    7. BIS — audit the other three instrument drivers for the SCPI wire-format test gap and the binary-read chunking pattern, per § 4.6.
    8. BIS — audit request/response model consistency across all four instrument routers, per § 4.6.
    9. Item 20 — RRSP/RRIF app: HLA review against MitchellNET stack, then build.
    10. Phase 3 — Monitoring (not yet scoped). Phase 4 — IoT (not yet scoped).

KNOWN ISSUES — logged, not yet actioned:
    • ⚠️ RC-Experiments dual-channel bench-capture corruption bug — STILL UNRESOLVED after extensive investigation tonight. See § 4.7 for the complete diagnostic trail, disproven theories, and next-session plan. This is the top technical priority, right after the API key rotation.
    • BIS API key pasted in plaintext across SIX+ sessions (4–6 July 2026) — rotate. Extremely overdue.
    • GitHub Actions deprecation annotation (actions/setup-python@v5) — not a failure, flagged for maintenance.
    • BIS — multimeter/power-supply/signal-generator drivers lack driver-level SCPI wire-format tests; unaudited. See § 4.6.
    • BIS — request/response model nesting inconsistency across the four instrument routers, not yet audited. See § 4.6.
    • RC-Experiments — no requirements.txt; BIS_REPO_PATH/BIS_API_KEY env vars still not persisted across Windows/Parallels sessions (documented in README.md tonight, but the underlying lack of persistence is not fixed). See § 4.6.
    • DMM cross-check voltage readings erratic during every bench-capture attempt tonight — not investigated, possibly related to § 4.7's bug, possibly separate.
    • Two doc sections (bench-instrument-service docs/ARCHITECTURE.md, RC-Experiments docs/architecture.md) currently overclaim that tonight's shipped fixes resolved the corruption bug — needs correcting once the real fix is known. See § 4.7 next-session plan item 7.
    • Recipe file upload 413 — NGINX client_max_body_size. Workaround: compress to JPEG.
    • InsanelyGoodRecipes.com import — Andrew to verify it saved a real recipe not a listing page.
    • No UPS on server.
    • AI meal planning — full browser functional test not yet done.
    • "Not Secure" badge on https://192.168.2.10/api/bench/docs — root cause unknown, low priority.

RESOLVED SINCE 4 JULY (no longer open):
    • RC-Experiments component-measurement bug (OL/stray readings) — resolved 5 July daytime; physical bench connection issue, not software.
    • BIS bench_client.py's measure() docstring mode-string mismatch — fixed 5 July daytime, PR #21.
    • BIS missing remote oscilloscope-configuration endpoint (trigger settings) — fixed 5 July daytime, PR #22.
    • BIS oscilloscope coupling silently failing to apply — fixed 5 July evening, PRs #25–#26.
    • BIS oscilloscope SCPI wire-format test gap — closed 5 July evening, PR #27.
    • RC-Experiments stale `points=` argument and manual scope-config step — fixed 5 July late-evening, PR #6.
    • BIS `capture_waveform()` SARA? channel-prefix hang — fixed 5 July late-evening, PR #28.
    • BIS `bench_client.py` capture_waveform() docstring drift — fixed 5 July late-evening, PR #29.
    • RC-Experiments run_bench() envelope-shape mismatch (was left uncommitted 5 July late-evening) — committed and merged 6 July late-night, PR #7.
    • BIS capture_waveform() binary-read handling — a defensive chunking loop was added and deployed (PR #31), but this is NOT confirmed to be the fix for the actual corruption bug — see § 4.7. Listed here only to record that the PR shipped, not that the underlying bug is resolved.
    • RC-Experiments capture_dual_channel() — switched to a single-request BIS call (PR #8) instead of two — genuinely good practice, shipped and deployed, but NOT confirmed to be the fix for the actual corruption bug — see § 4.7. Same caveat as above.

STILL OPEN / NOT RESOLVED (do not mark these resolved without live re-verification):
    • ⚠️ RC-Experiments dual-channel bench-capture corruption bug (§ 4.7) — root cause unknown. Two fixes shipped tonight did not resolve it.

---

Current state as of end of 7 July 2026 late-night session (supersedes the 6 July summary above for the § 4.7 bug specifically — the 6 July snapshot is left unedited above as accurate historical record of that point in time):

COMPLETED THIS SESSION (7 July late-night) — full detail in § 4.9:
    • bench-instrument-service PR #40 — query() retry-with-backoff for transient VISA timeouts; docs/scpi-block-transfer-protocol.md; examples/raw_scope_test.py (new canonical standalone diagnostic). 123 passed, deployed, verified green.
    • bench-instrument-service PR #41 — acquisition settle delay in /configure after a timebase change. 125 passed, deployed, verified green.
    • bench-instrument-service PR #42 — THE ACTUAL FIX for § 4.7: capture_waveforms() single stop/read-all/restore cycle, replacing the per-channel stop/restore that caused channel 2 to come back empty. New live-hardware pytest tier (tests/test_oscilloscope_hardware.py, BIS_HARDWARE_TESTS=1) — all 3 tests, each targeting one of tonight's three real bugs, ran and passed against the real scope before merging. 127 passed (mocked), deployed, verified green.
    • RC-Experiments PR #9 — docs updated to record the (at-the-time-believed) fix; stale duplicate script removed.
    • RC-Experiments PR #10 — capture_validation.py (test-first, 6 cases written and confirmed failing before the module existed); wired into run_bench(); client-side settle delay; tests/test_run_bench.py (proves the wiring, not just the validator); tests/test_hardware_integration.py (live-hardware tier, RC_HARDWARE_TESTS=1) — this tier is what actually caught the still-open bug live and later confirmed the fix, including one test deliberately left failing until PR #42 deployed. docs/testing.md (new).
    • § 4.7 bug CONFIRMED RESOLVED via a full, real, end-to-end --scenario 2 --bench run — first ever successful completion, no crash, capture_validation passed silently (both channels matching/populated/plausible), comparison plot generated.
    • Immediately after confirming § 4.7 resolved, a NEW, separate, unrelated bug was found in the resulting comparison plot (RC_Experiment2_S2_comparison.png): a time-domain misalignment between simulated and measured time axes inflates the reported RMS/max residual (2.22V RMS, 4.96V max) even though the underlying measured data closely matches simulation in the region where both actually overlap. Root cause, full detail, and two proposed fixes (awaiting scope decision) are in § 4.9's "NEXT SESSION — START HERE" subsection.
    • Session paused at Andrew's request (tired). Roadmap updated (this entry) with full session detail preserved for tomorrow.

ACTIVE PROJECTS / NEXT SESSION OPTIONS, IN ORDER:
    1. ⚠️ FIRST — rotate the BIS API key. SEVEN+ sessions overdue now (4 July, 5 July ×3, 6 July, 7 July). Cheap, safe, unrelated to any current bug. Do it before diving into fix #1/#2 below.
    2. ⚠️ TOP TECHNICAL PRIORITY — implement Fix #1 (clip comparison to the real overlapping time window between sim_t and bench["probe_b_time"]) and, pending Andrew's go-ahead, Fix #2 (align simulation and measurement time origins on a common reference edge) for the new time-domain-alignment bug found tonight. Full detail in § 4.9. Same test-first process as tonight: write a failing test reproducing the exact mismatch first.
    3. Once the comparison bug is fixed and a --bench run produces trustworthy RMS/max residual numbers, write experiment-2-series-rc/README.md (still not written — was blocked on § 4.7 all along, now blocked on the new bug instead).
    4. Item 21 — RC-Experiments, Experiment 1 (Bias-T): not started.
    5. BIS — audit the other three instrument drivers (multimeter, power supply, signal generator) for the same driver-level SCPI wire-format test gap and live-hardware test tier that oscilloscope now has. See § 4.6 and § 4.9 backlog.
    6. BIS — audit request/response model consistency across all four instrument routers, per § 4.6.
    7. Item 20 — RRSP/RRIF app: HLA review against MitchellNET stack, then build.
    8. Phase 3 — Monitoring (not yet scoped). Phase 4 — IoT (not yet scoped).

KNOWN ISSUES — logged, not yet actioned:
    • ⚠️ NEW 7 July — RC-Experiments comparison/plotting time-domain misalignment bug. See § 4.9. Top technical priority, right after the API key rotation.
    • BIS API key pasted in plaintext across SEVEN+ sessions (4–7 July 2026) — rotate. Extremely overdue.
    • GitHub Actions deprecation annotation (actions/setup-python@v5) — not a failure, flagged for maintenance.
    • BIS — multimeter/power-supply/signal-generator drivers lack driver-level SCPI wire-format tests and the live-hardware test tier oscilloscope now has; unaudited. See § 4.6 and § 4.9.
    • BIS — request/response model nesting inconsistency across the four instrument routers, not yet audited. See § 4.6.
    • RC-Experiments — no requirements.txt; BIS_REPO_PATH/BIS_API_KEY env vars still not persisted across Windows/Parallels sessions. See § 4.6.
    • capture_validation.py's voltage-plausibility check uses a per-element Python loop instead of numpy min/max — backlog, not urgent. See § 4.9.
    • tests/test_run_bench.py reloads run_experiment.py fresh in every test rather than caching the module — backlog, not urgent. See § 4.9.
    • DMM cross-check readings — deprioritized per Andrew's explicit instruction tonight; not useful to the experiment's actual goal. See § 4.9.
    • Recipe file upload 413 — NGINX client_max_body_size. Workaround: compress to JPEG.
    • InsanelyGoodRecipes.com import — Andrew to verify it saved a real recipe not a listing page.
    • No UPS on server.
    • AI meal planning — full browser functional test not yet done.
    • "Not Secure" badge on https://192.168.2.10/api/bench/docs — root cause unknown, low priority.

RESOLVED SINCE 6 JULY (no longer open):
    • ⚠️ RC-Experiments dual-channel bench-capture corruption bug (§ 4.7) — RESOLVED 7 July 2026. Root cause: per-channel TRMD acquisition restore during sequential capture calls. Fixed in BIS PR #42, confirmed via live-hardware tests in both repos and a full successful end-to-end --bench run. See § 4.9.
    • Large waveform block transfer placeholder-header issue (byte_count=0 while payload still in flight) — fixed 7 July, BIS PR #40 (chunk_size/timeout).
    • Transient single-query VISA timeouts (~6-7% observed rate) — fixed 7 July, BIS PR #40 (retry-with-backoff).
    • Acquisition-settle timing after a timebase change (empty buffer if /capture lands before the first sweep under new settings completes) — fixed 7 July, BIS PR #41 (server-side) and RC-Experiments PR #10 (client-side, independent of BIS's fix).

STILL OPEN / NOT RESOLVED (do not mark these resolved without live re-verification):
    • ⚠️ NEW 7 July — RC-Experiments comparison/plotting time-domain misalignment bug. Two fixes proposed (§ 4.9), neither implemented yet. Top technical priority for next session, right after the API key rotation.


---

Current state as of end of 8 July 2026 session (supersedes the 7 July summary above for § 4.9 specifically -- the 7 July snapshot is left unedited above as accurate historical record of that point in time):

COMPLETED THIS SESSION (8 July):
    * RC-Experiments PR #11 -- Fix #1 (clip residual/comparison to the real sim/bench overlap window) and Fix #2 (align sim/bench time origins via a shared first-rising-edge reference) both implemented in compare_and_plot(), via three new pure functions: find_first_rising_edge(), align_bench_time_to_sim(), compute_overlap_residual(). compare_and_plot() now returns a stats dict (rms_residual, max_residual, time_shift_s, overlap_start_s, overlap_end_s) instead of nothing. Test-first: tests/test_compare_and_plot.py (7 new tests) written and confirmed failing before implementation, confirmed passing after. Full suite 20 passed / 3 skipped (hardware tests gated as usual). Merged, branch cleaned up.
    * RC-Experiments PR #12 -- Removed the leftover TEMP DIAGNOSTIC print block in run_bench() (dead debug logging from the 7 July Sec 4.9 session, marked "remove before merging real fix" in its own comment but never actually removed after the real fix shipped).
    * Hardware-verified via a real --scenario 2 --bench run on the Windows/Parallels terminal: time shift applied -2.999961s (scope trigger was ~3 divisions/~3s offset from sim's t=0, matches the 0.25s/div timebase), overlap window 0.0000s-6.0000s (full simulated duration now covered after alignment, versus cutting off at ~3.5s before the fix), RMS residual 0.1372V, max residual 0.6551V -- down from the buggy 2.22V RMS / 4.96V max recorded in Sec 4.9. DMM cross-check still erratic (0.437V vs ~2.5V expected) -- unchanged, still deprioritized per Andrew's standing instruction, not investigated.
    * RC-Experiments PR #13 -- Wrote experiment-2-series-rc/README.md (was a 1-line stub since the file was created) -- overview, circuit, cached component values, scenarios, running instructions, environment setup, output files, comparison methodology (documents Fix #1/#2), DMM cross-check caveat, test instructions, status.
    * RC-Experiments PR #14 -- Added requirements.txt (numpy, matplotlib -- undocumented since run_experiment.py was first written, flagged as tech debt in Sec 4.6) and documented it in both README.md (repo-root) and experiment-2-series-rc/README.md. Confirmed via a fresh check that bench-instrument-service's own requirements.txt has no numpy/matplotlib dependency -- this was purely an RC-Experiments gap, not a BIS one.
    * Sec 4.9's time-domain comparison bug is now CLOSED. Sec 4.7 (bench-capture corruption, resolved 7 July) and Sec 4.9 (time-domain alignment, resolved 8 July) together mean Experiment 2's --bench workflow is fully working end-to-end for the first time.
    * BIS API key rotation -- explicitly deferred again tonight at Andrew's request (now EIGHT+ sessions overdue: 4 July, 5 July x3, 6 July, 7 July, 8 July). Andrew pasted the live key in chat again this session to unblock the Windows/Parallels env var setup. Still the standing first-action-item for next session per Sec 1.

EXPERIMENT 2 -- WHAT IT DOES AND HOW IT RUNS (reference summary, written this session ahead of the workflow-revisit planning discussion below):
    Purpose: a teaching/validation tool. Drives a real R1-C1 series circuit with a square wave and compares the physical circuit's charge/discharge curve against the theoretical RC step response predicted by QSPICE simulation, to build intuition for RC theory. First of a planned series of experiments in this repo (Experiment 1, Bias-T, not started).
    Steps on a --scenario N --bench run:
        1. Component values: load_component_values() reads cached R1/C1 from results/component-values.json (measured once via DMM, not every run). --remeasure-components is a separate standalone invocation that overwrites the cache.
        2. Scenario setup: build_scenarios() derives tau, half-period, sim duration for the requested scenario. Scenario 2 (1Hz, ~7 tau half-period) is the "clean textbook curve" case.
        3. Simulation: build_netlist() writes a QSPICE netlist (PULSE source + R1 + C1 + .tran), run_simulation() shells out to QSPICE (Windows-only), parse_qraw() parses the .qraw output into sim_t/sim_v_in/sim_v_mid. Same regardless of --bench.
        4. Bench capture (--bench only): run_bench() opens a BIS session, configures the SDG to output the same square wave, configures the scope (timebase/V-div/trigger derived from frequency), captures both channels in one BIS request, validates the capture shape, takes a DMM cross-check reading (deprioritized, unreliable). Returns measured time/voltage arrays for both probes.
        5. Comparison: compare_and_plot() overlays sim vs. measured, aligns bench time onto sim's time axis via a shared rising-edge reference (Fix #2), restricts the residual calc to the real overlap window (Fix #1), prints/returns RMS/max residual, saves a comparison PNG.
        6. Output: .cir, .qraw, _comparison.png, component-values.json in results/.
    Known friction points noted this session (not yet acted on): the workflow straddles two machines (Mac for editing/git, Windows/Parallels for anything touching QSPICE or --bench, since QSPICE is Windows-only); BIS_REPO_PATH/BIS_API_KEY don't persist across PowerShell sessions (Sec 4.6, still open).

NEW -- WORKFLOW REVISIT GOALS FOR EXPERIMENT 2 (Andrew's direction, 8 July 2026, NOT YET SCOPED OR BUILT):
    Andrew wants to revisit experiment-2-series-rc's workflow with three specific goals in mind, intended to turn it into "a very powerful teaching tool around the topic of RC circuits":
    1. Revisit how/when the DMM measures R1 and C1. Currently a one-time, manually-triggered, cached measurement (--remeasure-components, results/component-values.json) -- not part of the normal --bench run flow at all. Andrew wants to reconsider the timing/integration of this measurement (exact scope of the change not yet discussed).
    2. A GUI that presents the real oscilloscope display side-by-side with a "virtual oscilloscope" showing the simulated waveform -- i.e. a live visual comparison, not just a static post-run PNG.
    3. An AI-generated analysis (likely via the Claude API integration already used elsewhere in this project, e.g. recipes) of the differences between the real and simulated traces -- explaining why the differences exist and what they mean, in the context of RC circuit theory.
    None of this is scoped yet -- next session should start with a planning discussion (architecture, scope, which pieces are MVP vs. later) before any code is written, per the project's standing HLA-review-before-code pattern (see Item 20/RRSP for precedent).

ACTIVE PROJECTS / NEXT SESSION OPTIONS, IN ORDER:
    1. FIRST -- rotate the BIS API key. EIGHT+ sessions overdue now. Cheap, safe, unrelated to anything else. Do it before the planning discussion below.
    2. TOP PRIORITY -- planning discussion for the Experiment 2 workflow revisit (three goals above): DMM R1/C1 measurement timing, side-by-side real/virtual oscilloscope GUI, AI-generated difference analysis. Scope this before writing any code.
    3. Item 21 -- RC-Experiments, Experiment 1 (Bias-T): not started.
    4. BIS -- audit the other three instrument drivers (multimeter, power supply, signal generator) for the same driver-level SCPI wire-format test gap and live-hardware test tier that oscilloscope now has. See Sec 4.6.
    5. BIS -- audit request/response model consistency across all four instrument routers, per Sec 4.6.
    6. RC-Experiments -- BIS_REPO_PATH/BIS_API_KEY still don't persist across Windows/Parallels PowerShell sessions (Sec 4.6, unchanged).
    7. Item 20 -- RRSP/RRIF app: HLA review against MitchellNET stack, then build.
    8. Phase 3 -- Monitoring (not yet scoped). Phase 4 -- IoT (not yet scoped).

KNOWN ISSUES -- logged, not yet actioned:
    * BIS API key pasted in plaintext across EIGHT+ sessions (4-8 July 2026) -- rotate. Extremely overdue.
    * RC-Experiments Experiment 2 workflow revisit -- not yet scoped, see NEW GOALS above. Top priority after the key rotation.
    * BIS -- multimeter/power-supply/signal-generator drivers lack driver-level SCPI wire-format tests and the live-hardware test tier oscilloscope now has; unaudited. See Sec 4.6.
    * BIS -- request/response model nesting inconsistency across the four instrument routers, not yet audited. See Sec 4.6.
    * RC-Experiments -- BIS_REPO_PATH/BIS_API_KEY env vars still not persisted across Windows/Parallels sessions. See Sec 4.6.
    * capture_validation.py's voltage-plausibility check uses a per-element Python loop instead of numpy min/max -- backlog, not urgent. See Sec 4.9.
    * tests/test_run_bench.py reloads run_experiment.py fresh in every test rather than caching the module -- backlog, not urgent. See Sec 4.9.
    * DMM cross-check readings -- deprioritized per Andrew's explicit instruction; not useful to the experiment's actual goal. Still present in run_bench(), unchanged tonight.
    * Recipe file upload 413 -- NGINX client_max_body_size. Workaround: compress to JPEG.
    * InsanelyGoodRecipes.com import -- Andrew to verify it saved a real recipe not a listing page.
    * No UPS on server.
    * AI meal planning -- full browser functional test not yet done.
    * "Not Secure" badge on https://192.168.2.10/api/bench/docs -- root cause unknown, low priority.

RESOLVED SINCE 7 JULY (no longer open):
    * RC-Experiments comparison/plotting time-domain misalignment bug (Sec 4.9) -- RESOLVED 8 July 2026. Fix #1 (clip to real overlap window) + Fix #2 (align time origins via shared rising edge), both implemented, test-first, hardware-verified (RMS 0.137V / max 0.655V, down from 2.22V/4.96V). RC-Experiments PR #11.
    * Leftover TEMP DIAGNOSTIC debug logging in run_bench() -- removed, RC-Experiments PR #12.
    * experiment-2-series-rc/README.md -- written, RC-Experiments PR #13.
    * numpy/matplotlib dependency -- undocumented since the script was first written, now declared in requirements.txt and documented, RC-Experiments PR #14.

STILL OPEN / NOT RESOLVED (do not mark these resolved without live re-verification):
    * BIS API key rotation -- still not done, eight+ sessions overdue.
    * Experiment 2 workflow revisit (DMM timing, side-by-side GUI, AI analysis) -- not yet scoped, planning discussion is next session's top priority.
