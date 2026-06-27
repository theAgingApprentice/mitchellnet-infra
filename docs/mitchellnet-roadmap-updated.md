MitchellNET Roadmap — Full Picture
Last updated: 26 June 2026 (end of session — recipes PRs #32–#35 shipped; InternalWebServer PR #169; DB backup confirmed live; AI meal planning live; Help page live; nav links added)

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
    • ✅ Item 15: Recipes app — scaffold + full UI complete (17 June 2026) ◦ recipes repo created via aaNewService recipes --type python-flask-db ◦ Flask + MariaDB running at https://mitchellnet.local/recipes/ ◦ Full CI/CD pipeline: test → deploy → health check all passing ◦ PRs #1–#13: scaffold, core models, routes, meal plan, shopping list, HTML UI, NGINX routing fixes, template fixes, save redirect fix, README dev notes ◦ Browse, add, edit, delete, meal plan, shopping list all functional
    • ✅ mitchellnet-infra PR #30: Fix aaNewService template backlog items A–F (17 June 2026)
    • ✅ mitchellnet-infra PR #31: docs updated with NGINX multi-prefix exception, url_for warning, HTML template warning (17 June 2026)
    • ✅ InternalWebServer: nginx-routing.md Flask Service Routing Patterns section added (17 June 2026)
    • ✅ InternalWebServer website updates (17 June 2026): ◦ Recipes link fixed → /recipes/ ◦ Vaultwarden added to Infrastructure → Hosted Services card ◦ Workshop renamed to Workspaces (home page, hub page, nav header) ◦ Music Studio hub card added to Workspaces page ◦ README routing table updated with recipes entries
    • ✅ Anthropic API account created (17 June 2026): ◦ Account: Google login via va3wam@gmail.com at https://platform.claude.com ◦ $5 USD credits purchased (pay-as-you-go, separate from Claude.ai subscription) ◦ API key mitchellnet-recipes created and saved to Vaultwarden ◦ ANTHROPIC_API_KEY added to ~/services/recipes/.env on server
    • ✅ RRSP/RRIF Withdrawal Planning — analysis complete, documents produced (18 June 2026): ◦ Full financial model built: year-by-year simulation 2026–2084, Ontario tax engine, RRIF minimums, CPP/OAS deferral ◦ Pension income splitting optimised: $105,785 lifetime tax saving identified ◦ Mitchell_RRSP_Report.docx — full analysis with charts, income splitting tables, milestones ◦ Mitchell_RRSP_BRD.docx — 24 functional requirements for production web app ◦ Mitchell_RRSP_HLA.docx — proposed architecture (NOTE: review against existing MitchellNET stack before build) ◦ Item 20 added to Feature/Build Work table for production build
    • ✅ 18 June 2026 session — recipes PR #3 (Claude API import) completed and hardened: ◦ recipes PR #16 — Claude API recipe import (URL fetch + document upload) merged, deployed, CI green ◦ recipes PR #17 — fixed Claude max_tokens 1000 → 4096 ◦ recipes PR #18 — BRD and HLA updated to v1.1 ◦ Live functional test successful: imported "Garlic Prawns (Shrimp)" from RecipeTin Eats
    • ✅ 20 June 2026 session — Bare-IP routing & cert parity fixed: ◦ mitchellnet-infra PRs #36–#39, InternalWebServer PRs #167–#168 ◦ Bare-IP Parity Standard documented and enforced by aaNewService checklist ◦ nginx-routing.md fully audited and rewritten
    • ✅ 20 June 2026 evening session — recipes PR #4 (5 of 7 items) + recipe data migration first pass (44 of 48 recipes imported)
    • ✅ 22 June 2026 session — recipes PR #4 item 6 (prep-ahead flag), PR #5 (Cook Log UC-08 + UC-15), PR #5 URL fix. BRD/HLA updated to v1.2. main at 55f13fa.
    • ✅ 23 June 2026 session — recipes PRs #28–#31 all shipped and verified: ◦ recipes PR #28 — Fix shopping list ingredient aggregation. main → 441ac62. ◦ recipes PR #29 — Dynamic cuisine list from DB + admin page at /recipes/admin/. main → fe9b357. ◦ recipes PR #30 — BRD and HLA updated to v1.3. main → 4d98707. ◦ recipes PR #31 — dish_type field full stack (11 files). main → c2f7c54. ◦ Test record cleanup ✅. Cuisine picklist expansion ✅ (18 cuisines in DB, dynamic).
    • ✅ 26 June 2026 session — recipes PRs #32–#35 + InternalWebServer PR #169 all shipped and verified:
        ◦ DB backup cron job — confirmed live and healthy: 3 consecutive nightly runs (24, 25, 26 June at 02:00), 3/3 retention working, backup.log clean. Script at ~/backups/recipes/backup_recipes_db.sh. § 5.5 gap CLOSED.
        ◦ recipes PR #32 — AI meal planning (UC-16): ai_planner service, ai_plan routes, suggest.html + review.html templates, RejectionReason + AiSuggestion models, admin Rejection Reasons section, AI Suggest button on meal plan page, init.sql updated. Merged, CI green (1m 41s). main → 0d9d473.
        ◦ InternalWebServer PR #169 — NGINX /ai-plan/ and /recipe-links/ location blocks added to both prod.conf and 000-bareip.conf. Bare-IP parity maintained. Merged, CI green (19s). main → 699de06.
        ◦ recipes PR #33 — Searchable Help page at /recipes/help with "? Help" link in every page header (11 topic sections, client-side JS search). Merged, CI green (3m 17s). main → 0bec434.
        ◦ recipes PR #34 — Meal Plan and Shopping List nav links added to browse page header. Merged, CI green (1m 23s). main → c8fdc55.
        ◦ recipes PR #35 — Recipes back link added to Meal Plan and Shopping List pages; Shopping List button updated with 🛒 emoji. Merged, CI green (1m 39s). main → 0292f19.

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
Phase 0.5 — Bare-IP / Name Parity Standard ✅ COMPLETE (20 June 2026) — all path-based services now reachable identically via mitchellnet.local and 192.168.2.10; enforced going forward by aaNewService

Feature/Build Work
    • Item 15 (Recipes app) — PRs #1–#6 ✅ COMPLETE; PR #7 ✅ COMPLETE (26 June); PRs #8–#10 planned (see § 5)
    • Item 20 (RRSP/RRIF app) — analysis complete, build not started

Phase 3 — Monitoring
Phase 4 — IoT

    4. aaNewService — Known Issues
Items A–F fixed in mitchellnet-infra PR #30 (17 June 2026). ✅
Checklist updated 20 June 2026 (mitchellnet-infra PR #37) to explicitly name both NGINX vhost files. ✅

    5. Recipes App — Remaining PRs
    • PR #7 — ✅ COMPLETE (26 June 2026): AI meal planning (UC-16) — ai_planner service, ai_plan routes + templates, rejection_reasons + ai_suggestions models, admin Rejection Reasons section, AI Suggest button, init.sql updated. InternalWebServer PR #169 — NGINX /ai-plan/ + /recipe-links/ blocks both vhosts.
    • PR #8 (planned) — Recipe linking (UC-17): recipe_links DB table, recipe_links routes, detail + form template updates
    • PR #9 (planned) — Wishlist un-flag prompt (UC-08 enhancement): prompt after "We made this!" on wishlist recipes
    • PR #10 (planned) — 6 cookbook recipes manual entry (Nagi cookbook + New Nagi cookbook page references)
    • Recipe-level rating system — deferred pending CookLog usage review
    • fetcher.py AllRecipes 403 — low priority, logged 20 June
    • Recipe file upload 413 fix — low priority (client_max_body_size in both NGINX vhosts + Flask MAX_CONTENT_LENGTH)
    • GitHub Actions deprecation annotation (actions/setup-python@v5 / Node.js 20) — low priority, flagged for mitchellnet-infra maintenance pass
    • Full browser functional test of AI meal planning flow — not yet done (Andrew to test suggest → review → accept/reject → meal plan populated)

    5.5 Recipes App — DB Backup ✅ COMPLETE (26 June 2026)
Nightly cron job running on server. Script: ~/backups/recipes/backup_recipes_db.sh. Dumps to ~/backups/recipes/recipes_db_YYYY-MM-DD.sql. Retains last 3. Log: ~/backups/recipes/backup.log. Confirmed: 3 consecutive successful runs (24, 25, 26 June). Restore procedure documented in runbook.md.

    6. RRSP/RRIF Withdrawal Planning App — Item 20
Planning and analysis complete. Three documents produced. Build not yet started. HLA review against existing MitchellNET stack still pending before any code is written.

    6.5 Known Issues — Logged, Not Yet Actioned
    • "Not Secure" browser badge on https://192.168.2.10/api/bench/docs despite a valid, trusted cert — root cause not identified. Low priority, functionality unaffected. See runbook.md § Incident Log.
    • AllRecipes.com import returns 403 Forbidden from services/fetcher.py — scraper/bot detection on AllRecipes' side. Fix (e.g. realistic User-Agent header) would be its own small PR.
    • GitHub Actions deprecation annotation: "Node.js 20 is deprecated... actions/setup-python@v5" — not a failure. Flagged for mitchellnet-infra maintenance pass.
    • Recipe file import fails with 413 Request Entity Too Large above ~1MB — NGINX's default client_max_body_size. Workaround: rasterize large PDFs to compressed JPEG. Real fix: client_max_body_size in both NGINX vhost files + check Flask MAX_CONTENT_LENGTH.
    • InsanelyGoodRecipes.com import (https://insanelygoodrecipes.com/vietnamese-recipes/) may be a category page not a single recipe — Andrew to check the saved recipe's detail page.
    • No UPS installed on the server — open follow-up from the 18→19 June power-loss reboot.

    7. Lessons Learned — NGINX + Flask Routing
At the start of any new session involving Flask services or NGINX routing, request these two documents before writing any code:
    • recipes/README.md — Development Notes section (Approach A, multi-prefix exception, url_for warning, HTML templates)
    • InternalWebServer/docs/nginx-routing.md — Flask Service Routing Patterns section (same patterns, plus full location block map for all existing services, plus the Bare-IP Parity Standard added 20 June 2026)

Summary of key rules
    • Approach A: trailing slash on proxy_pass strips the prefix — Flask routes use simple paths
    • Multi-prefix exception: secondary prefixes (e.g. /recipes/api/, /meal-plan/, /shopping-list/) use proxy_pass without trailing slash to preserve the full path
    • url_for() is prefix-unaware: always use hard-coded absolute paths for redirects (e.g. redirect(f"/recipes/{r.id}"))
    • HTML anchor tags only: Jinja2 templates must use <a> tags — Markdown-style links render as literal text
    • Bare-IP parity: every service location block must be added to BOTH nginx/conf.d/prod.conf AND nginx/conf.d/000-bareip.conf — exception: subdomain-based services (currently only Vaultwarden)
    • Template action= and href= values must include the /recipes/ prefix — always smoke-test new routes with curl -sk immediately after deploy
    • Always verify a live record exists before using its ID in curl smoke tests — a 404 from get_or_404() looks identical to a routing 404
    • Picklist dropdowns in templates must use object.name (e.g. {{ c.name }}) when the list comes from a DB query returning model objects — not {{ c }} which was correct for the old hardcoded string lists (NEW — 23 June 2026, caught during dish_type PR)

7.5 Lessons Learned — Claude API Integration
    • max_tokens must be generous: use 4096 as a baseline for structured extraction tasks
    • Don't share Claude API call functions across services with different system prompts
    • curl smoke tests on the server need -k flag (self-signed cert)
    • VSCode Claude plugin can silently mangle large file overwrites — verify with wc -l and head/tail

7.6 Lessons Learned — Documentation & Process
    • A documented warning doesn't prevent a mistake — the durable fix is updating tooling (aaNewService checklist), not re-stating the warning
    • When a doc claims to be a complete reference, verify against live files (cat / diff)
    • Pasted terminal output can introduce copy/paste artifacts — verify with direct Python file read before assuming the file is broken
    • DB changes must go through the repo (init.sql + models), not directly on the server — so a rebuild can reproduce the full schema from scratch

7.7 Lessons Learned — One-Item-Per-PR Workflow & Live Verification
    • Split multi-item scoped work into one PR per item — keeps diffs small and reviewable
    • GitHub merge screen "X checks pending" badge lags behind actual Actions run — check Actions tab directly
    • Code-review-confidence and live-behavior-confidence are different things — always live-test features with actual data

    8. InternalWebServer — Site Structure
Navigation: Home | Engineering | Workspaces | Infrastructure | Projects | About

Hosted Apps
    • /fitness/ — Fitness Tracker
    • /recipes/ — Recipes app (Flask + MariaDB)
    • /rrsp/ — RRSP/RRIF Withdrawal Planning app (planned — Item 20)

Infrastructure → Hosted Services
    • Vaultwarden — https://vault.mitchellnet.local/

    8.5 InternalWebServer — Backlog / Maintenance
    1. Re-clone InternalWebServer to the standard repo location (~/Documents/visualStudioCode/newProjectStructure/InternalWebServer). Currently at ~/Documents/visualStudioCode/html/projects/InternalWebServer — the one exception to the newProjectStructure pattern. Approach: fresh clone to new path, verify aaGitPromote/aaGitCleanupBranches work from new location, then delete old clone. Update Standing Instructions REPOS section once done.
    2. Site IA / structure cleanup — audit which pages are linked vs. orphaned (recipes.html was orphaned, may be others), then redesign. Not scoped yet.

    9. Resume Prompt (paste this verbatim to start the next session)

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

FLASK + NGINX: At the start of any session involving Flask services or NGINX routing, request these two docs before writing any code:
    • recipes/README.md — Development Notes section
    • InternalWebServer/docs/nginx-routing.md — Flask Service Routing Patterns section (includes the Bare-IP Parity Standard — every location block must exist in both nginx/conf.d/prod.conf and nginx/conf.d/000-bareip.conf, except subdomain-based services like Vaultwarden which are exempt)

PLUGIN WARNINGS:
    • If the VSCode plugin's diff for a large file replacement looks too small or suspicious, verify with wc -l and head/tail before trusting it — the plugin can silently truncate large file overwrites
    • If a file gets mangled, generate it as a downloadable artifact instead and have me copy it into the repo manually
    • If pasted terminal output looks suspicious around word boundaries (especially near em dashes), verify with a direct cat of the file before troubleshooting further

REPOS (all at ~/Documents/visualStudioCode/newProjectStructure/<repo> except InternalWebServer):
    • fitness-tracker — https://mitchellnet.local/fitness/
    • bench-instrument-service (BIS) — https://mitchellnet.local/api/bench/ and https://192.168.2.10/api/bench/
    • mitchellnet-infra — scripts, runbook, architecture docs, roadmap
    • InternalWebServer — NGINX config, static HTML (at ~/Documents/visualStudioCode/html/projects/InternalWebServer)
    • vaultwarden — https://vault.mitchellnet.local/
    • recipes — https://mitchellnet.local/recipes/ (Flask + MariaDB, full UI + Claude import + prep-ahead + cook log + dish_type + admin + AI meal planning + help page all live; main at 0292f19)
    • mitchellnet-rrsp — NOT YET CREATED (Item 20, planned)

SERVER: Ubuntu iMac at 192.168.2.10, SSH as andrew@192.168.2.10. Services run from ~/services/<repo>/. All credentials in Vaultwarden at https://vault.mitchellnet.local/ and in server .env files. No UPS currently installed.


MitchellNET — Standing Instructions
Workflow
    • You (Claude) plan/review; I execute via three channels: (1) SERVER TERMINAL — SSH commands on the server, (2) DEV MAC TERMINAL — terminal commands in a repo on the Mac Studio, (3) VSCODE CLAUDE PLUGIN — file edits via the Claude plugin in a named repo window.
    • Every instruction must be labelled with which channel, which repo, and which branch before any command or instruction text.
    • Repos are separate VSCode windows — always complete work in one repo before switching, and never mix instructions for two repos in one step.
    • For literal file dumps, give raw cat/grep/git diff commands to run in the DEV MAC TERMINAL rather than asking the VSCode plugin to "show" or "summarize" a file.
    • Always pipe git diff through cat to prevent pager hang: git diff | cat
    • After any edit, get the git diff | cat before promoting, to catch stray changes.
    • Stay on main in the terminal at all times — aaGitPromote creates the branch itself.
    • If I paste terminal output back and something looks like a word got merged or split unexpectedly (especially around em dashes or punctuation), treat it as a possible paste artifact first — verify against the real file directly before assuming the file itself is broken.

Git Workflow
    • Commit via aaGitPromote <branch-name> "<commit message>" (creates branch, commits, pushes, prints PR link). Run from main in DEV MAC TERMINAL.
    • I open/merge PRs via GitHub UI after CI passes. I do not click "Delete branch" in GitHub.
    • After merge, clean up via aaGitCleanupBranches (switches to main, deletes local+remote branch, pulls latest).

Deploy Verification
    • After merge, check the Actions tab for "Deploy to Production" — if it fails, check container logs via docker compose logs <service> --tail=50 before assuming the code change is broken.

Repos
    • fitness-tracker (Flask) — https://192.168.2.10/fitness/ and https://mitchellnet.local/fitness/
    • bench-instrument-service / BIS (FastAPI) — https://mitchellnet.local/api/bench/ and https://192.168.2.10/api/bench/
    • mitchellnet-infra — scripts (aaGitPromote, aaGitCleanupBranches, etc.), runbook, architecture docs, roadmap
    • InternalWebServer — NGINX config, static HTML, docker-compose for nginx-proxy + nginx-prod
    • vaultwarden — https://vault.mitchellnet.local/ (subdomain vhost, exempt from bare-IP parity by design)
    • recipes — https://mitchellnet.local/recipes/ (Flask + MariaDB, full UI + Claude import + prep-ahead + cook log + dish_type + admin + AI meal planning + help page all live)
    • mitchellnet-rrsp — NOT YET CREATED (Item 20, planned)

Bare-IP / Name Parity Standard (NEW — 20 June 2026)
    • Every path-based service location block must exist in both nginx/conf.d/prod.conf and nginx/conf.d/000-bareip.conf — enforced by aaNewService's checklist.
    • Subdomain-based services (currently only Vaultwarden) are exempt — there is no bare-IP equivalent of a subdomain.
    • Full detail: InternalWebServer/docs/nginx-routing.md § Bare-IP Parity Standard, and mitchellnet-infra/docs/runbook.md § SSL Certificate Renewal and § Incident Log.

Secrets
Server .env files are source of truth. Vaultwarden is live and fully populated — use it as the credential reference.

Repo Locations on Mac Studio
    • newProjectStructure repos: ~/Documents/visualStudioCode/newProjectStructure/<repo>
    • InternalWebServer: ~/Documents/visualStudioCode/html/projects/InternalWebServer


Current state as of end of 26 June 2026 session:

COMPLETED THIS SESSION:
    • DB backup cron job — confirmed live and healthy (3 nightly runs, retention working). Gap closed.
    • recipes PR #32 — AI meal planning (UC-16) full stack. main → 0d9d473.
    • InternalWebServer PR #169 — NGINX /ai-plan/ + /recipe-links/ blocks, both vhosts. main → 699de06.
    • recipes PR #33 — Searchable Help page at /recipes/help, "? Help" link in every page header. main → 0bec434.
    • recipes PR #34 — Meal Plan + Shopping List nav links added to browse page. main → c8fdc55.
    • recipes PR #35 — Recipes back link on Meal Plan and Shopping List pages. main → 0292f19.
    • roadmap updated to reflect 26 June session.

KNOWN ISSUES — logged, not yet actioned, not blocking:
    • AllRecipes.com import returns 403 Forbidden — scraper/bot detection. Fix is its own small PR.
    • GitHub Actions deprecation annotation (actions/setup-python@v5) — not a failure, flagged for maintenance.
    • Recipe file upload 413 — NGINX client_max_body_size. Workaround: compress to JPEG.
    • InsanelyGoodRecipes.com import — Andrew to verify it saved a real recipe not a listing page.
    • No UPS on server.
    • AI meal planning — full browser functional test not yet done (Andrew to test end-to-end flow).

RECIPE MIGRATION STATUS:
    • 44 of 48 URLs imported (20 June). porkStroganoff.pdf imported as compressed JPEG.
    • 4 URLs permanently discarded: AllRecipes (403), AgingLikeWine (404), Yummly (dead), FoodNetwork.ca (SSL error).
    • REMAINING: 6 cookbook page references (Nagi cookbook + New Nagi cookbook) — need manual "Add Recipe" entry (PR #10).

NEXT SESSION FOCUS: recipes PR #8 — Recipe linking (UC-17): recipe_links DB table (init.sql + model), recipe_links routes, detail + form template updates. Also consider PR #9 (wishlist un-flag prompt) and PR #10 (6 cookbook manual entries) if time permits. At start of session request recipes/README.md and InternalWebServer/docs/nginx-routing.md per standing instructions.
