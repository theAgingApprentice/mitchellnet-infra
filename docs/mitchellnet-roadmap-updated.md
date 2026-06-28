MitchellNET Roadmap — Full Picture
Last updated: 28 June 2026 (end of session — InternalWebServer PRs #171–#177 shipped; repo and server cleanup complete; site IA redesign complete)

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
    • Item 21 (RC-Circuit) — New project. See § 9 below.
    • InternalWebServer — ✅ COMPLETE (28 June 2026). All PRs #171–#177 shipped. Repo restructured, cleaned, and site IA redesign done.

Phase 3 — Monitoring: Not yet scoped.
Phase 4 — IoT: Not yet scoped.

    4. aaNewService — Known Issues
Items A–F fixed in mitchellnet-infra PR #30 (17 June 2026). ✅
Checklist updated 20 June 2026 (mitchellnet-infra PR #37) to explicitly name both NGINX vhost files. ✅

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

    9. RC-Circuit — Item 21 (New Project)

    Overview
    A rewrite of RC_Experiment1.py from the electricityExperiment-AcVsDc repo. The goal is to compare simulated RC circuit behaviour against live bench instrument measurements and provide an AI analysis of any similarities and differences.

    Key facts
    • Source repo: https://github.com/theAgingApprentice/electricityExperiment-AcVsDc
    • File to rewrite: RC_Experiment1.py (existing docs in that repo explain the experiment in detail)
    • New repo name: RC-Circuit (to be created)
    • Dev environment: Mac Studio (macOS) — code developed and edited on Mac
    • Run environment: Windows OS running under Parallels Desktop on the same Mac Studio
    • Depends on: bench-instrument-service (BIS) — live instrument readings via the BIS API

    What it will do
    1. Run an RC circuit simulation (replicating what RC_Experiment1.py does today)
    2. Simultaneously read live measurements from real bench instruments via the BIS API (oscilloscope, multimeter, signal generator, power supply as needed)
    3. Compare simulated results against live instrument readings
    4. Call Claude API to provide a plain-English analysis of similarities and differences between the simulation and live measurements

    Prerequisites before build starts
    • Review electricityExperiment-AcVsDc repo docs to understand the existing experiment scope and simulation approach
    • Confirm which BIS endpoints are needed (waveform capture, multimeter logging, etc.)
    • Decide on repo structure (pure Python script vs. Flask app vs. something else)
    • Decide on output format (terminal, HTML report, saved file)
    • Confirm Parallels/Windows Python environment and how the BIS API will be reached from Windows (same LAN — 192.168.2.10)

    Status: 🔲 Not yet started — prerequisites above must be resolved before coding begins.

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
    • Stay on main branch in all terminals at all times — aaGitPromote creates the feature branch itself
    • For file contents, give me raw cat/grep commands to run in the terminal rather than asking the VSCode plugin to "show" files
    • Promote via: aaGitPromote <branch-name> "<commit message>" (run from main in the repo terminal)
    • Clean up via: aaGitCleanupBranches (after PR is merged in GitHub UI)
    • Never click "Delete branch" in GitHub UI — the cleanup script handles it

PR WORKFLOW:
    • I open and merge PRs via GitHub UI after CI passes
    • After merge, always check the Actions tab for "Deploy to Production" directly — don't rely on the GitHub merge screen's check-status badge

DB CHANGES: Never make DB changes directly on the server. All schema changes go through init.sql and models in the repo, deployed via CI/CD. This ensures a server rebuild can reproduce the full schema from scratch.
NOTE: The live DB does not automatically pick up new CREATE TABLE IF NOT EXISTS statements on redeploy when the DB container already exists. After the first deploy of any PR that adds a new table, apply it via:
    docker exec -i recipes-db mariadb -u root -p"$(grep MYSQL_ROOT_PASSWORD ~/services/recipes/.env | cut -d= -f2)" recipes_db -e "<DDL statement>"

FLASK + NGINX: At the start of any session involving Flask services or NGINX routing, request these two docs before writing any code:
    • recipes/README.md — Development Notes section
    • InternalWebServer/docs/nginx-routing.md — Flask Service Routing Patterns section (includes the Bare-IP Parity Standard — every location block must exist in both nginx/conf.d/prod.conf and nginx/conf.d/000-bareip.conf, except subdomain-based services like Vaultwarden which are exempt)


Current state as of end of 28 June 2026 session:

COMPLETED THIS SESSION:
    • InternalWebServer PR #171 — Content reorganisation: Facilities card (Infrastructure), Subscriptions card (Home), Pilot hole sizes to Wood Shop, Electrical & Workshop card removed.
    • InternalWebServer PR #172 — Repo cleanup: 63 stale files deleted.
    • InternalWebServer PR #173 — Deploy workflow fix: stale backend rsync removed.
    • InternalWebServer PRs #174/#175 — Repo restructure: html/prod/ → site/, workshop/ → workspaces/.
    • InternalWebServer PRs #176/#177 — Final cleanup: stale files removed, orphaned pages deleted, Projects removed from nav.
    • Server cleanup: html/ directory removed, all orphan files removed from ~/web_server/.
    • mitchellnet-infra runbook and bootstrap.sh verified correct for fresh rebuild — no changes needed.
    • InternalWebServer site IA redesign ✅ COMPLETE.
    • Roadmap updated.

ACTIVE PROJECTS / NEXT SESSION OPTIONS:
    • Item 20 — RRSP/RRIF app: HLA review against MitchellNET stack, then build
    • Item 21 — RC-Circuit: review electricityExperiment-AcVsDc docs, scope the rewrite, create new repo
    • Phase 3 — Monitoring (not yet scoped)
    • Phase 4 — IoT (not yet scoped)

KNOWN ISSUES — logged, not yet actioned, not blocking:
    • GitHub Actions deprecation annotation (actions/setup-python@v5) — not a failure, flagged for maintenance.
    • Recipe file upload 413 — NGINX client_max_body_size. Workaround: compress to JPEG.
    • InsanelyGoodRecipes.com import — Andrew to verify it saved a real recipe not a listing page.
    • No UPS on server.
    • AI meal planning — full browser functional test not yet done (Andrew to test end-to-end flow).
    • "Not Secure" badge on https://192.168.2.10/api/bench/docs — root cause unknown, low priority.
