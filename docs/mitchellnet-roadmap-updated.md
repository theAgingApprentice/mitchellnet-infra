MitchellNET Roadmap — Full Picture
Last updated: 5 July 2026, evening session (BIS oscilloscope coupling bug found, root-caused against real hardware, and fixed across two PRs; SCPI wire-format test gap that let it slip through closed with a new driver-level test file; README.md and docs/ARCHITECTURE.md updated to match)

Completed
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
        ◦ bench-instrument-service PR #27 — Closed the underlying test gap: all existing oscilloscope tests mock the driver itself, so none of them actually exercise the SCPI strings sent to write() — neither bug above would have been caught by CI. Added tests/test_oscilloscope_driver.py (13 new tests) which mocks only the VISA resource one layer down and asserts on literal SCPI strings (e.g. "C1:CPL D1M"). Updated README.md's Project Structure test list (added test_oscilloscope_driver.py and the previously-undocumented test_bench_client_contracts.py) and docs/ARCHITECTURE.md (fixed a stale test list that still referenced a nonexistent test_instruments.py and was missing five real test files; added a new "Router-level vs. driver-level instrument tests" section documenting the distinction for future contributors). Bench-verified via pytest (112 passed) and deployed.
        ◦ All three PRs merged and deployed via the standard CI/CD pipeline (GitHub Actions self-hosted runner, "Deploy to Production" workflow, verified green in the Actions tab each time — not just the merge-screen badge, per § 7.7).
        ◦ Session hygiene issue found and corrected: aaGitCleanupBranches was run with a typo ("yews") after PR #25's merge, aborting the cleanup and leaving the merged branch checked out locally. This caused a second commit (the D1M/A1M fix) to almost land on top of the stale already-merged branch instead of main. Caught before promoting; resolved via git stash → checkout main → pull → delete stale branch (local + remote) → stash pop, with no data loss. See § 7.9 for the resulting process fix.
        ◦ BIS API key was pasted in plaintext again this session (multiple terminal commands) — same recurring issue flagged 4–5 July. Still not rotated.
        ◦ Roadmap updated (this entry).

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
    • Item 21 (RC-Experiments, renamed from RC-Circuit) — In progress. See § 9 below.
    • InternalWebServer — ✅ COMPLETE (28 June 2026). All PRs #171–#177 shipped. Repo restructured, cleaned, and site IA redesign done.

Phase 3 — Monitoring: Not yet scoped.
Phase 4 — IoT: Not yet scoped.

    4. aaNewService — Known Issues
Items A–F fixed in mitchellnet-infra PR #30 (17 June 2026). ✅
Checklist updated 20 June 2026 (mitchellnet-infra PR #37) to explicitly name both NGINX vhost files. ✅

    4.5 BIS — Feature Gaps Found via RC-Experiments (4 July 2026) ✅ COMPLETE (5 July 2026)
Found while building RC-Experiments' shared/src/bis_client.py and experiment-2-series-rc/src/run_experiment.py against the real bench_client.py and app/models/multimeter.py. All items below fixed in bench-instrument-service PRs #21–#23 (5 July 2026):
    • ✅ bench_client.py's measure() docstring listed invalid mode strings (DCV, ACV, DCI, ACI, PER). Fixed: default mode and docstring now match the real MeasurementMode Literal (VOLT:DC, VOLT:AC, CURR:DC, CURR:AC, RES, FRES, FREQ, CONT, DIOD, CAP). README.md examples fixed too. (PR #21)
    • ✅ No oscilloscope configuration endpoint existed for trigger settings — every experiment run required manually setting trigger source/level/slope/mode on the front panel. Fixed: configure_trigger()/trigger_status() added to the driver, new nested TriggerConfigRequest/TriggerStatus models, wired into POST /v1/oscilloscope/configure and GET /v1/oscilloscope/status. Bench-verified live against the SDS1202X-E. (PR #22)
    • ✅ docs/ARCHITECTURE.md and BIS_BRD.docx updated to document the trigger capability. BIS_HLA.docx reviewed, no change needed (architectural doc, doesn't describe endpoint-level detail). (PR #23)
    • "Not Secure" browser badge on /api/bench/docs (§ 6.5) — still open, unrelated to the above.

    4.6 BIS / RC-Experiments — Tech Debt Logged 5 July 2026
    • BIS — audit request/response model consistency across all four instrument routers (oscilloscope, multimeter, power supply, signal generator). Oscilloscope trigger config uses a nested TriggerConfigRequest sub-object (added 5 July alongside the trigger feature, matching the response-side nesting pattern); need to check whether multimeter/PSU/sig-gen follow the same nested pattern or are flat, and standardize on one approach service-wide. Not urgent — logged for later, not blocking current work.
    • RC-Experiments — no requirements.txt in the repo; run_experiment.py needs numpy and matplotlib, which aren't documented anywhere. Also, BIS_REPO_PATH and BIS_API_KEY environment variables are required to run any experiment script (via shared/src/bis_client.py) but aren't documented in the repo README or anywhere else. Discovered 5 July while debugging the Experiment 2 component-measurement issue. Not urgent, but will bite the next fresh checkout/environment.
    • ✅ RESOLVED (5 July 2026 evening) — BIS oscilloscope test suite could not catch SCPI wire-format bugs, because every router-level oscilloscope test mocked the driver itself rather than the underlying VISA resource. This is exactly how the coupling bug (below) shipped without CI ever flagging it. Closed via bench-instrument-service PR #27 — see the 5 July evening Completed entry above for full detail. The same gap likely still exists for the other three instrument drivers (multimeter, power supply, signal generator) — none of them have an equivalent driver-level wire-format test file yet. Logged as a new item below.
    • BIS — multimeter, power supply, and signal generator drivers have no driver-level SCPI wire-format tests (the pattern added for the oscilloscope in PR #27). Any of them could have a live bug identical in kind to the oscilloscope coupling bug, undetected by the existing router-level-only test suite. Not urgent, but worth an audit pass — pick one driver, verify its SCPI syntax against the real instrument the same way the oscilloscope's was verified (lxi discover + direct pyvisa script), and add the equivalent test file.

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
    • BIS API key was pasted in plaintext during the 4 July 2026 chat session (both in a terminal paste and in this document), and again during the 5 July 2026 session. Low urgency but should be rotated in BIS's config once convenient.

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

7.8 Lessons Learned — Workflow Discipline
    • Always use aaGitPromote to create feature branches — never commit directly to a feature branch or push manually, as this bypasses the PR trigger and the deploy workflow will not fire
    • After any edit that needs fixing, do NOT push manually to the open branch — instead open a new PR from that branch via GitHub UI so the deploy fires on merge
    • Stay on main branch in all terminals at all times between PRs — aaGitPromote creates the feature branch itself
    • When a deploy workflow fails, read the full error before actioning — the failing step name and error message identify the exact fix needed

7.9 Lessons Learned — Hardware SCPI Verification & Session Hygiene (5 July 2026)
    • Never trust a driver's own docstring/comments for real instrument wire-format syntax — verify directly against the physical instrument. The oscilloscope coupling bug shipped twice (DC1M/AC1M, then still wrong) because both attempts were guesses based on the driver's own (incorrect) query-response comments, not the real instrument. The only way this got resolved was talking to the scope directly over pyvisa (bypassing BIS) and testing candidate command strings one at a time.
    • lxi discover (from lxi-tools, brew install lxi-tools) is the fast way to find an LXI/VXI-11 instrument's LAN IP when it's not documented or has changed — broadcasts on the LAN and returns identity + IP for every compliant instrument. Faster and cleaner than a port scan.
    • A test suite that only mocks the driver (router-level tests) cannot catch bugs in the actual commands a driver sends to hardware. If a service talks to real instruments/hardware over a wire protocol, at least one test file per driver should mock only the transport layer (e.g. the VISA resource) and assert on literal wire strings — see bench-instrument-service's tests/test_oscilloscope_driver.py for the pattern.
    • Uncommitted local work-in-progress left at the end of a session is a real risk: a prior session's channel_config/timebase nesting fix was built and apparently working locally but never committed/promoted, so production silently kept running the old broken code for an entire subsequent session before anyone noticed. End every session by either committing/promoting real fixes or explicitly logging them as "not yet committed" in the roadmap — don't let them sit invisibly in a working tree.
    • Branch cleanup (aaGitCleanupBranches) should run immediately after every merge, before any further verification or new work — not deferred. Deferring it risks a second commit landing on top of an already-merged, not-yet-deleted branch instead of main (nearly happened this session; caught and fixed via git stash + branch resync, no data lost).
    • When giving Claude Mac-terminal instructions to inspect changes, ask for the exact command to run (e.g. "give me the command"), not just "give me a diff" — keeps every step fully explicit and pasteable without interpretation.

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
    2. Site IA fixes ✅ COMPLETE (27 June 2026) — PR #170: include path fixes, stale link fixes, about.html updated
    3. Site IA redesign ✅ COMPLETE (28 June 2026) — PRs #171–#177: content reorganised, repo restructured (html/prod→site, workshop→workspaces), orphaned pages removed, nav simplified, repo and server cleaned up

    9. RC-Experiments — Item 21 (renamed from RC-Circuit, in progress)

    Overview
    A repo of electronics-learning experiments, each comparing simulated (QSPICE) circuit behaviour against live bench instrument measurements (via BIS) and explaining the result against theory. Started as a rewrite of RC_Experiment1.py from the electricityExperiment-AcVsDc repo; now designed to hold many future experiments, one root-level directory each.

    Key facts
    • Repo: https://github.com/theAgingApprentice/RC-Experiments (live, private)
    • Dev environment: Mac Studio (macOS) — code developed and edited on Mac
    • Run environment: Windows OS running under Parallels Desktop on the same Mac Studio (QSPICE is Windows-only)
    • Depends on: bench-instrument-service (BIS) — live instrument readings via the BIS API, wrapped by shared/src/bis_client.py (RCBenchClient) rather than talked to directly
    • Original source material: electricityExperiment-AcVsDc repo's RC_Experiment1.py and docs (Lab Guide, Setup Guide, Instructions) — used as reference, not ported verbatim, since real measured component values changed the underlying numbers

    Repo structure
    docs/ (concepts/ + architecture.md) — general glossary, circuit theory, unit conversions, electricity fundamentals, and the sim+BIS+Claude architecture, shared across every experiment
    shared/src/ — RCBenchClient (BIS wrapper), used by every experiment
    experiment-1-bias-t/ — fritzing/, src/, docs/, results/ — not yet built
    experiment-2-series-rc/ — fritzing/ (series-rc.fzz), docs/ (theory.md), src/ (run_experiment.py) — built, not yet successfully run end-to-end

    What each experiment does
    1. Run a QSPICE simulation of the circuit
    2. Read live measurements from real bench instruments via BIS (oscilloscope, multimeter, signal generator)
    3. Compare simulated results against live instrument readings (residual plot, RMS/max stats)
    4. (Planned, not yet built) Call Claude API to provide a plain-English analysis of similarities and differences against the theory being taught

    Experiment 2 — Series RC — status
    • Theory, Fritzing reference design, and run script all built (PRs #3–#5)
    • --remeasure-components workflow's OL/stray-reading bug (5 July 2026) — resolved, root cause was a physical bench connection issue, not software. See § 4.6 session log for full detail.
    • Fresh, trustworthy measured values (5 July 2026, properly isolated): R1 ≈ 9911Ω, C1 ≈ 7.0µF, τ ≈ 0.0694s — supersedes the earlier R1 = 10.42kΩ/C1 = 8.52µF figures quoted from the 4 July session, which were pre-bug-discovery and not the values now cached in component-values.json
    • experiment-2-series-rc/README.md not yet written (waiting until the script has had at least one clean successful --sim-only or --bench run)

    Experiment 1 — Bias-T — status
    • Not yet started. Circuit is a genuinely different topology from series RC (inductor + capacitor combining a DC bias and an AC signal, not a time-constant charge/discharge) — needs its own theory doc, its own Fritzing design (new part: an inductor), and its own breadboard build.

    BIS feature gaps found while building this — ✅ all fixed 5 July 2026 (see § 4.5 for full detail)
    • ✅ bench_client.py's measure() docstring had invalid mode strings vs. the real API — fixed
    • ✅ No remote oscilloscope-configuration endpoint for trigger settings — added
    • ✅ BIS_HLA.docx/BIS_BRD.docx and docs/ARCHITECTURE.md updated

    Status: 🟢 Experiment 2 built, component-measurement bug resolved, fresh calibration data captured. Not yet run end-to-end via --sim-only or --bench. Experiment 1 not started. BIS feature-gap fixes are complete, so both experiments can now be fully bench-automated once run.

    10. Resume Prompt (paste this verbatim to start the next session)

Resuming MitchellNET work.

Workflow rules — read these carefully and follow them for every instruction in this session:

INSTRUCTION FORMAT: Every instruction you give me must clearly state one of the following at the start:
    • SERVER TERMINAL — command to run via SSH on andrew@192.168.2.10
    • DEV MAC TERMINAL — command to run in the terminal on my Mac Studio (state which repo directory I should be in and confirm I am on the main branch)
    • VSCODE CLAUDE PLUGIN — instruction to give to the Claude plugin in VSCode (state which repo window and which branch)
Never mix instructions for two repos in a single step. Never give a VSCode instruction without naming the repo and branch first.

ONE REPO AT A TIME: I have separate VSCode windows per repo. Always complete all work in one repo before switching to another.

COMMAND RULES:
    • Always pipe git diff through cat: git diff | cat
    • Always get a diff before promoting: after any edit, run git diff | cat and paste back for review
    • Always give me the exact command to run — say "run this command," not "give me a diff" or other indirect phrasing — so every step is fully explicit and pasteable without interpretation
    • Stay on main branch in all terminals at all times — aaGitPromote creates the feature branch itself
    • For file contents, give me raw cat/grep commands to run in the terminal rather than asking the VSCode plugin to "show" files
    • Promote via: aaGitPromote <branch-name> "<commit message>" (run from main in the repo terminal)
    • Clean up via: aaGitCleanupBranches (after PR is merged in GitHub UI) — run this immediately after every merge, before any further verification or new work, not deferred
    • Never click "Delete branch" in GitHub UI — the cleanup script handles it
    • Type cleanup confirmations ("yes") carefully — a typo aborts the cleanup and leaves a stale branch checked out, risking a later commit landing on the wrong branch

PR WORKFLOW:
    • I open and merge PRs via GitHub UI after CI passes
    • After merge, always check the Actions tab for "Deploy to Production" directly — don't rely on the GitHub merge screen's check-status badge

DB CHANGES: Never make DB changes directly on the server. All schema changes go through init.sql and models in the repo, deployed via CI/CD. This ensures a server rebuild can reproduce the full schema from scratch.
NOTE: The live DB does not automatically pick up new CREATE TABLE IF NOT EXISTS statements on redeploy when the DB container already exists. After the first deploy of any PR that adds a new table, apply it via:
    docker exec -i recipes-db mariadb -u root -p"$(grep MYSQL_ROOT_PASSWORD ~/services/recipes/.env | cut -d= -f2)" recipes_db -e "<DDL statement>"

FLASK + NGINX: At the start of any session involving Flask services or NGINX routing, request these two docs before writing any code:
    • recipes/README.md — Development Notes section
    • InternalWebServer/docs/nginx-routing.md — Flask Service Routing Patterns section (includes the Bare-IP Parity Standard — every location block must exist in both nginx/conf.d/prod.conf and nginx/conf.d/000-bareip.conf, except subdomain-based services like Vaultwarden which are exempt)


Current state as of end of 5 July 2026 evening session:

COMPLETED THIS SESSION (5 July evening):
    • Diagnosed and fixed a real BIS bug: oscilloscope channel coupling silently failed to apply via configure_oscilloscope(), even though scale/timebase changes worked.
    • bench-instrument-service PR #25 — Shipped a prior session's never-committed channel_config/timebase/trigger nested-request-model fix (production had been running the old flat-shape code this whole time), plus a first, still-incorrect coupling fix (DC1M/AC1M).
    • bench-instrument-service PR #26 — Found and fixed the real bug: used lxi discover + a direct pyvisa script against the scope (192.168.2.45) to determine the actual SCPI wire format is D1M/A1M/GND, not DC1M/AC1M/GND. Fixed both the write path and the status-read parser. Confirmed live: coupling now correctly reads back DC after a DC write.
    • bench-instrument-service PR #27 — Added tests/test_oscilloscope_driver.py (13 tests) asserting literal SCPI strings sent to write(), closing the gap that let both bugs above ship silently. Updated README.md and docs/ARCHITECTURE.md test lists and documented the router-level vs. driver-level test distinction.
    • All three PRs merged and deployed; deploy workflow verified green in the Actions tab each time.
    • Corrected a git housekeeping near-miss (aborted branch cleanup left a stale branch checked out) — see § 7.9.
    • Full detail: see the "5 July 2026 evening session" entry under Completed, and § 4.6 / § 7.9.

ACTIVE PROJECTS / NEXT SESSION OPTIONS:
    • Item 21 — RC-Experiments, Experiment 2: not yet run end-to-end via --sim-only or --bench (the component-measurement bug that blocked this is resolved — see 5 July daytime session). Run it, then write experiment-2-series-rc/README.md.
    • Item 21 — RC-Experiments, Experiment 1 (Bias-T): not started. Needs its own theory doc, Fritzing design (new inductor part), and breadboard build.
    • BIS — audit the other three instrument drivers (multimeter, power supply, signal generator) for the same SCPI wire-format test gap just closed for the oscilloscope; add driver-level tests per driver once each is verified against real hardware. See § 4.6.
    • BIS — audit request/response model consistency across all four instrument routers (nested vs. flat). See § 4.6.
    • Rotate the BIS API key — pasted in plaintext across multiple sessions now (4 July, 5 July daytime, 5 July evening). This is the most overdue item on the list.
    • Item 20 — RRSP/RRIF app: HLA review against MitchellNET stack, then build.
    • Phase 3 — Monitoring (not yet scoped).
    • Phase 4 — IoT (not yet scoped).

KNOWN ISSUES — logged, not yet actioned:
    • BIS API key pasted in plaintext across multiple sessions (4–5 July 2026) — rotate. Overdue.
    • GitHub Actions deprecation annotation (actions/setup-python@v5) — not a failure, flagged for maintenance.
    • BIS — multimeter/power-supply/signal-generator drivers lack the driver-level SCPI wire-format tests just added for the oscilloscope; unaudited against real hardware. See § 4.6.
    • BIS — request/response model nesting inconsistency across the four instrument routers, not yet audited. See § 4.6.
    • RC-Experiments — no requirements.txt (needs numpy, matplotlib) and no documentation of the required BIS_REPO_PATH / BIS_API_KEY environment variables. See § 4.6.
    • Recipe file upload 413 — NGINX client_max_body_size. Workaround: compress to JPEG.
    • InsanelyGoodRecipes.com import — Andrew to verify it saved a real recipe not a listing page.
    • No UPS on server.
    • AI meal planning — full browser functional test not yet done (Andrew to test end-to-end flow).
    • "Not Secure" badge on https://192.168.2.10/api/bench/docs — root cause unknown, low priority.

RESOLVED SINCE 4 JULY (no longer open):
    • RC-Experiments component-measurement bug (OL/stray readings) — resolved 5 July daytime; physical bench connection issue, not software. See § 6.5 history / § 4.6.
    • BIS bench_client.py's measure() docstring mode-string mismatch — fixed 5 July daytime, PR #21.
    • BIS missing remote oscilloscope-configuration endpoint (trigger settings) — fixed 5 July daytime, PR #22.
    • BIS oscilloscope coupling silently failing to apply — fixed 5 July evening, PRs #25–#26.
