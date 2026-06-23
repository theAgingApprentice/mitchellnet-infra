MitchellNET Roadmap — Full Picture
Last updated: 23 June 2026 (end of afternoon session — recipes PRs #28–#31 shipped; BRD/HLA updated to v1.3; new features scoped: UC-16 AI meal planning, UC-17 recipe linking, dish_type field)

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
    • ✅ 23 June 2026 session — recipes PRs #28–#31 all shipped and verified: ◦ recipes PR #28 — Fix shopping list ingredient aggregation: quantities now collected and combined with + instead of first-seen-wins. Merged, deployed, CI green (1m 20s). main → 441ac62. ◦ recipes PR #29 — Dynamic cuisine list from DB + admin page: cuisines table seeded with all 18 live values; CUISINES hardcoded constant removed; Cuisine model added; admin page at /recipes/admin/ with Add Cuisine form; ⚙ Admin link in every page header. Merged, deployed, CI green (1m 19s). main → fe9b357. ◦ recipes PR #30 — BRD and HLA updated to v1.3: UC-16 AI Meal Planning, UC-17 Recipe Linking, dish_type field, wishlist un-flag prompt, admin picklist extensions (dish_types, rejection_reasons), ai_suggestions tracking table. Merged, deployed. main → 4d98707. ◦ recipes PR #31 — dish_type field full stack: DB migration (dish_type column on recipes + dish_types table seeded with 7 values); DishType model; browse/add/edit/import routes updated; form.html + browse.html + detail.html + review.html templates updated; browse cuisine filter bug fixed (was using string instead of object .name); dish_type filter added to browse; admin Dish Types section added; extractor schema + system prompt updated for auto-detection. Merged, deployed, CI green (1m 22s). main → c2f7c54. ◦ Test record cleanup — ✅ DONE (Andrew cleaned up test, test, test3, test4 records from production DB) ◦ Cuisine picklist expansion — ✅ DONE (all 18 live cuisines now in DB, dynamic from cuisines table)

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
    • Item 15 (Recipes app) — PRs #4, #5, #6 ✅ COMPLETE; PRs #7–#10 planned (see § 5)
    • Item 20 (RRSP/RRIF app) — analysis complete, build not started

Phase 3 — Monitoring
Phase 4 — IoT

    4. aaNewService — Known Issues
Items A–F fixed in mitchellnet-infra PR #30 (17 June 2026). ✅
Checklist updated 20 June 2026 (mitchellnet-infra PR #37) to explicitly name both NGINX vhost files. ✅

    5. Recipes App — Remaining PRs
    • PR #6 — ✅ COMPLETE (23 June 2026): shopping list aggregation fix (PR #28) + dynamic cuisine list + admin page (PR #29) + dish_type full stack (PR #31)
    • PR #7 (planned) — AI meal planning (UC-16): ai_planner service, ai_plan routes + templates, rejection_reasons + ai_suggestions DB tables, NGINX /ai-plan/ blocks in both vhosts
    • PR #8 (planned) — Recipe linking (UC-17): recipe_links DB table, recipe_links routes, detail + form template updates
    • PR #9 (planned) — Wishlist un-flag prompt (UC-08 enhancement): prompt after "We made this!" on wishlist recipes
    • PR #10 (planned) — 6 cookbook recipes manual entry (Nagi cookbook + New Nagi cookbook page references)
    • InternalWebServer PR (planned, with PR #7) — add /ai-plan/ and /recipe-links/ location blocks to prod.conf + 000-bareip.conf
    • Recipe-level rating system — deferred pending CookLog usage review
    • fetcher.py AllRecipes 403 — low priority, logged 20 June
    • Recipe file upload 413 fix — low priority (client_max_body_size in both NGINX vhosts + Flask MAX_CONTENT_LENGTH)
    • GitHub Actions deprecation annotation (actions/setup-python@v5 / Node.js 20) — low priority, flagged for mitchellnet-infra maintenance pass

    5.5 Recipes App — DB Backup Gap (NEW — 23 June 2026)
No automated backup of the recipes_db MariaDB volume exists. Confirmed: no crontab for user andrew on the server. The recipes_recipes_data Docker volume holds all recipe data and would be lost if the volume is corrupted or the server is rebuilt without a prior dump.

Required fix (not yet implemented):
    • Add a cron job on the server to run mysqldump inside the recipes-db container nightly, saving to a dated file on the host (e.g. ~/backups/recipes/recipes_db_YYYY-MM-DD.sql)
    • Retain last N dumps (suggest 7 days)
    • Verify the backup file is non-zero after each run
    • Document the restore procedure in runbook.md
    • Consider whether the same gap exists for other MariaDB-backed services (fitness-tracker uses SQLite — not affected; BIS uses InfluxDB — check separately)

This is the highest-priority infrastructure item not yet addressed.

    6. RRSP/RRIF Withdrawal Planning App — Item 20
Planning and analysis complete. Three documents produced. Build not yet started. HLA review against existing MitchellNET stack still pending before any code is written.

    6.5 Known Issues — Logged, Not Yet Actioned
    • "Not Secure" browser badge on https://192.168.2.10/api/bench/docs despite a valid, trusted cert — root cause not identified. Low priority, functionality unaffected. See runbook.md § Incident Log.
    • AllRecipes.com import returns 403 Forbidden from services/fetcher.py — scraper/bot detection on AllRecipes' side. Fix (e.g. realistic User-Agent header) would be its own small PR.
    • GitHub Actions deprecation annotation: "Node.js 20 is deprecated... actions/setup-python@v5" — not a failure. Flagged for mitchellnet-infra maintenance pass.
    • Recipe file import fails with 413 Request Entity Too Large above ~1MB — NGINX's default client_max_body_size. Workaround: rasterize large PDFs to compressed JPEG. Real fix: client_max_body_size in both NGINX vhost files + check Flask MAX_CONTENT_LENGTH.
    • InsanelyGoodRecipes.com import (https://insanelygoodrecipes.com/vietnamese-recipes/) may be a category page not a single recipe — Andrew to check the saved recipe's detail page.
    • No UPS installed on the server — open follow-up from the 18→19 June power-loss reboot.
    • recipes_db has no automated backup — see § 5.5 for detail and required fix.

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

We use this workflow: you tell me step-by-step what to either (1) run on the server SSH terminal, (2) run on the Dev Mac terminal, or (3) tell the Claude plugin in VSCode to do — one repo at a time, since I have to switch VSCode windows per repo. Always tell me which repo I should be working in before giving instructions. I paste back outputs/diffs for your review before we proceed. For commits we use aaGitPromote <branch> "<msg>" and aaGitCleanupBranches (never delete branches via GitHub UI — I don't click "Delete branch" on GitHub either, the script handles it). PRs are merged via GitHub UI after CI passes. For literal file dumps, give me raw cat/grep commands rather than asking the plugin to "show" files. Always pipe git diff through cat to prevent pager hang: git diff | cat. After any edit, get the diff before promoting.

We stay on the main branch at all times in the Dev Mac terminal — aaGitPromote creates the feature branch itself, commits, and pushes; I never manually git checkout -b.

At the start of any session involving Flask services or NGINX routing, request these two docs before writing any code:
    • recipes/README.md — Development Notes section
    • InternalWebServer/docs/nginx-routing.md — Flask Service Routing Patterns section (includes the Bare-IP Parity Standard — every location block must exist in both nginx/conf.d/prod.conf and nginx/conf.d/000-bareip.conf, except subdomain-based services like Vaultwarden which are exempt)

If the VSCode plugin's diff for a large file replacement looks too small or suspicious, verify with wc -l and head/tail before trusting it — the plugin can silently truncate large file overwrites. If a file gets mangled, generate it as a downloadable artifact instead and have me copy it into the repo manually. If pasted terminal output looks suspicious around word boundaries (especially near em dashes), verify with a direct Python read of the file before troubleshooting further.

After every PR merge, check the Actions tab for "Deploy to Production" directly — don't rely on the GitHub merge screen's check-status badge.

When iterating on templates, always check whether dropdown/select options use {{ c }} vs {{ c.name }} — picklist values from DB queries return model objects, not strings. Using {{ c }} will render the Python object repr, not the name. (NEW lesson — 23 June 2026)

Current state as of end of 23 June 2026 afternoon session:

COMPLETED THIS SESSION:
    • recipes PR #28 — Fix shopping list ingredient aggregation. main → 441ac62.
    • recipes PR #29 — Dynamic cuisine list from DB + admin page at /recipes/admin/. main → fe9b357.
    • recipes PR #30 — BRD/HLA updated to v1.3 (UC-16 AI meal planning, UC-17 recipe linking, dish_type, wishlist un-flag, admin extensions). main → 4d98707.
    • recipes PR #31 — dish_type field full stack (11 files). main → c2f7c54.
    • Test record cleanup — ✅ DONE (Andrew)
    • Cuisine picklist expansion — ✅ DONE (18 cuisines in DB, dynamic)
    • roadmap updated to reflect 23 June session

KNOWN ISSUES — logged, not yet actioned, not blocking:
    • AllRecipes.com import returns 403 Forbidden — scraper/bot detection. Fix is its own small PR.
    • GitHub Actions deprecation annotation (actions/setup-python@v5) — not a failure, flagged for maintenance.
    • Recipe file upload 413 — NGINX client_max_body_size. Workaround: compress to JPEG.
    • InsanelyGoodRecipes.com import — Andrew to verify it saved a real recipe not a listing page.
    • No UPS on server.
    • recipes_db has no automated backup — HIGH PRIORITY infrastructure gap, see § 5.5.

RECIPE MIGRATION STATUS:
    • 44 of 48 URLs imported (20 June). porkStroganoff.pdf imported as compressed JPEG.
    • 4 URLs permanently discarded: AllRecipes (403), AgingLikeWine (404), Yummly (dead), FoodNetwork.ca (SSL error).
    • REMAINING: 6 cookbook page references (Nagi cookbook + New Nagi cookbook) — need manual "Add Recipe" entry.

NEXT SESSION FOCUS: recipes PR #7 — AI meal planning (UC-16). This is the largest remaining PR: new ai_planner service, ai_plan routes + templates, rejection_reasons + ai_suggestions DB tables (run migrations on server before coding), NGINX /ai-plan/ and /recipe-links/ location blocks in both InternalWebServer vhosts. Also address the recipes_db backup gap (§ 5.5) — set up cron job on server before or after PR #7.

REPOS (all at ~/Documents/visualStudioCode/newProjectStructure/<repo> except InternalWebServer):
    • fitness-tracker — https://mitchellnet.local/fitness/
    • bench-instrument-service (BIS) — https://mitchellnet.local/api/bench/ and https://192.168.2.10/api/bench/
    • mitchellnet-infra — scripts, runbook, architecture docs, roadmap
    • InternalWebServer — NGINX config, static HTML (at ~/Documents/visualStudioCode/html/projects/InternalWebServer)
    • vaultwarden — https://vault.mitchellnet.local/
    • recipes — https://mitchellnet.local/recipes/ (full UI + Claude import + prep-ahead + cook log + dish_type + admin all live; main at c2f7c54)
    • mitchellnet-rrsp — NOT YET CREATED (Item 20, planned)

SERVER: Ubuntu iMac at 192.168.2.10, SSH as andrew@192.168.2.10. Services run from ~/services/<repo>/. All credentials in Vaultwarden at https://vault.mitchellnet.local/ and in server .env files. No UPS currently installed.


MitchellNET — Standing Instructions
Workflow
    • You (Claude) plan/review; I execute via two channels: (1) server terminal commands, (2) instructions to the Claude plugin in VSCode for file edits within a repo.
    • Repos are separate VSCode windows — always tell me explicitly which repo I should be working in before giving instructions, and don't mix instructions for two repos in one step.
    • For literal file dumps, give me raw cat/grep/git diff commands to run myself rather than asking the VSCode plugin to "show" or "summarize" a file.
    • Always pipe git diff through cat to prevent pager hang: git diff | cat
    • After any edit, get the git diff | cat before promoting, to catch stray changes.
    • Stay on main in the terminal at all times — aaGitPromote creates the branch itself.
    • If I paste terminal output back and something looks like a word got merged or split unexpectedly (especially around em dashes or punctuation), treat it as a possible paste artifact first — verify against the real file directly before assuming the file itself is broken.

Git Workflow
    • Commit via aaGitPromote <branch-name> "<commit message>" (creates branch, commits, pushes, prints PR link). Run from main.
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
    • recipes — https://mitchellnet.local/recipes/ (Flask + MariaDB, full UI + Claude import + prep-ahead + cook log + dish_type + admin all live)
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
